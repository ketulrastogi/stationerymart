import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stationerymart/pages/home_page/home_page.dart';
import 'package:stationerymart/services/auth_service.dart';

class SignInPage extends StatefulWidget {
  final VoidCallback toggelSignIn;

  const SignInPage({Key key, this.toggelSignIn}) : super(key: key); 
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _username;
  String _password;

  bool _loading;

  @override
  void initState() {
    _loading = false;
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
          height: 300.0,
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              children: <Widget>[
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Mobile Number',),
                        keyboardType: TextInputType.number,
                        onSaved: (value){
                          setState(() {
                           _username = value.toString(); 
                          });
                        },
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Password',
                        ),
                        obscureText: true,
                        onSaved: (value){
                          setState(() {
                           _password = value.toString();
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
                      child: (_loading) ? 
                      Center(
                        child: SizedBox(
                          height: 28.0,
                          width: 28.0,
                          child: CircularProgressIndicator(),),
                      )
                      : Text(
                        'SIGN IN',
                        style: GoogleFonts.roboto(
                          textStyle: Theme.of(context).textTheme.title.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                        ),
                      ),
                      onPressed: (_loading) ? null : () async{
                        setState(() {
                         _loading = true; 
                        });
                        if(_formKey.currentState.validate()){
                          _formKey.currentState.save();
                          // _phoneController.text = '';
                          // _passwordController.text = '';
                          _formKey.currentState.reset();
                          Map<String, dynamic> response = await _authService.signIn(_username, _password);
                          Map<String, dynamic> userDetails = await _authService.getUserDetails();
                          setState(() {
                           _loading = false; 
                          });
                          if(response['Success']){
                            Navigator.push(context, 
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
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
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot password ?',
                    style: GoogleFonts.roboto(
                      textStyle: Theme.of(context).textTheme.subhead.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
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
