import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stationerymart/pages/authentication/authentication_page.dart';
import 'package:stationerymart/services/auth_service.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback toggelSignIn;

  const SignUpPage({Key key, this.toggelSignIn}) : super(key: key);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _name;
  String _phone;
  String _email;
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
                  'Sign Up',
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
                    'Sign In ➔',
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
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Full Name',),
                        onSaved: (value){
                          setState(() {
                           _name = value.toString(); 
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
                        border: OutlineInputBorder(),
                        labelText: 'Mobile Number',),
                        keyboardType: TextInputType.number,
                        onSaved: (value){
                          setState(() {
                           _phone = value.toString(); 
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
                        border: OutlineInputBorder(),
                        labelText: 'Email Address'),
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (value){
                          setState(() {
                           _email = value.toString(); 
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
                        border: OutlineInputBorder(), 
                        labelText: 'Password',
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
                      child: Text(
                        'SIGN UP',
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
                          Map<String, dynamic> response = await _authService.signUp(_name, _phone, _email, _password);
                          setState(() {
                           _loading = false; 
                          });
                          if(response['Success']){
                            Navigator.push(context, 
                              MaterialPageRoute(
                                builder: (context) => AuthenticationPage(),
                              ),
                            );
                          }
                        }
                        
                      },
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
