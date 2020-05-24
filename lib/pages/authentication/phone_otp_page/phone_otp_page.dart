import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stationerymart/pages/home_page/home_page.dart';
import 'package:stationerymart/services/auth_service.dart';

class PhoneOtpPages extends StatefulWidget {
  final VoidCallback toggelSignIn;

  const PhoneOtpPages({
    Key key,
    this.toggelSignIn,
  }) : super(key: key);
  @override
  _PhoneOtpPagesState createState() => _PhoneOtpPagesState();
}

class _PhoneOtpPagesState extends State<PhoneOtpPages> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  String _phoneNumber;
  String _otp;

  bool _otpSent = false;

  bool _loadingPhone;
  bool _loadingOtp;

  @override
  void initState() {
    _loadingPhone = false;
    _loadingOtp = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthService _authService = Provider.of<AuthService>(context);

    return ListView(
      padding: EdgeInsets.all(24.0),
      children: <Widget>[
        Center(
          child: Container(
            height: 150.0,
            width: 150.0,
            child: Image.asset('assets/StationeryMartLogo.jpg'),
          ),
        ),
        SizedBox(
          height: 32.0,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(
                  'Sign In',
                  style: GoogleFonts.roboto(
                    textStyle: Theme.of(context).textTheme.headline.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  widget.toggelSignIn();
                },
                child: Container(
                  child: Text(
                    'Sign Up ➔',
                    style: GoogleFonts.roboto(
                      textStyle: Theme.of(context).textTheme.subhead.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600,
                          ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 32.0,
        ),
        Container(
          height: 400.0,
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              children: <Widget>[
                (!_otpSent)
                    ? Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Mobile Number',
                                ),
                                keyboardType: TextInputType.number,
                                onSaved: (value) {
                                  setState(() {
                                    _phoneNumber = value.toString();
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 12.0,
                            ),
                            Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: RaisedButton(
                                  color: Theme.of(context).primaryColor,
                                  padding: EdgeInsets.symmetric(vertical: 16.0),
                                  child: (_loadingPhone)
                                      ? Center(
                                          child: SizedBox(
                                            height: 28.0,
                                            width: 28.0,
                                            child: CircularProgressIndicator(),
                                          ),
                                        )
                                      : Text(
                                          'SEND OTP',
                                          style: GoogleFonts.roboto(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .title
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                          ),
                                        ),
                                  onPressed: (_loadingPhone)
                                      ? null
                                      : () async {
                                          setState(() {
                                            _loadingPhone = true;
                                          });
                                          if (_formKey.currentState
                                              .validate()) {
                                            _formKey.currentState.save();
                                            // _phoneController.text = '';
                                            // _otpController.text = '';
                                            _formKey.currentState.reset();
                                            _otpSent = await _authService
                                                .sendOtp(_phoneNumber);
                                            Map<String, dynamic> userDetails =
                                                await _authService
                                                    .getUserDetails();
                                            setState(() {
                                              _loadingPhone = false;
                                              _otpSent = true;
                                            });
                                            if (!_otpSent) {
                                              Scaffold.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'An error occured while sending an OTP.',
                                                    style: GoogleFonts.roboto(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .subtitle
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                    ),
                                                  ),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            }
                                          }
                                        },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 12.0,
                            ),
                          ],
                        ),
                      )
                    : Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'OTP',
                                ),
                                obscureText: true,
                                onSaved: (value) {
                                  setState(() {
                                    _otp = value.toString();
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 12.0,
                            ),
                            Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: RaisedButton(
                                  color: Theme.of(context).primaryColor,
                                  padding: EdgeInsets.symmetric(vertical: 16.0),
                                  child: (_loadingOtp)
                                      ? Center(
                                          child: SizedBox(
                                            height: 28.0,
                                            width: 28.0,
                                            child: CircularProgressIndicator(),
                                          ),
                                        )
                                      : Text(
                                          'VERIFY OTP',
                                          style: GoogleFonts.roboto(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .title
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                          ),
                                        ),
                                  onPressed: (_loadingOtp)
                                      ? null
                                      : () async {
                                          setState(() {
                                            _loadingOtp = true;
                                          });
                                          if (_formKey.currentState
                                              .validate()) {
                                            _formKey.currentState.save();
                                            // _phoneController.text = '';
                                            // _otpController.text = '';
                                            _formKey.currentState.reset();
                                            bool _otpVerified =
                                                await _authService
                                                    .verifyOtp(_otp);
                                            // Map<String, dynamic> userDetails =
                                            //     await _authService.getUserDetails();
                                            setState(() {
                                              _loadingOtp = false;
                                            });
                                            if (_otpVerified) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePage(),
                                                ),
                                              );
                                            } else {
                                              Scaffold.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Wrong otp is entered.Please try again.',
                                                    style: GoogleFonts.roboto(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .subtitle
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                    ),
                                                  ),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            }
                                          }
                                        },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 24.0,
                            ),
                          ],
                        ),
                      ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _otpSent = false;
                    });
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Resend Otp?',
                      style: GoogleFonts.roboto(
                        textStyle: Theme.of(context).textTheme.subhead.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
