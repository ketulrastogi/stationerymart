import 'dart:convert';

import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stationerymart/pages/home_page/home_page.dart';
import 'package:stationerymart/services/auth_service.dart';
import 'package:stationerymart/services/cart_service.dart';
import 'package:stationerymart/services/location_service.dart';

class BuyerDetailsPage extends StatefulWidget {
  @override
  _BuyerDetailsPageState createState() => _BuyerDetailsPageState();
}

class _BuyerDetailsPageState extends State<BuyerDetailsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  String name;
  String email;
  String phone;
  String pincode;
  String address;
  String selectedState;
  String selectedDistrict;
  String selectedCity;
  String selectedPincode;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    LocationService locationService = Provider.of<LocationService>(context);
    AuthService authService = Provider.of<AuthService>(context);
    CartService cartService = Provider.of<CartService>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'User Profile',
            style: GoogleFonts.roboto(
              textStyle: Theme.of(context).textTheme.headline.copyWith(
                  color: Colors.blueGrey.shade900, fontWeight: FontWeight.bold),
            ),
          ),
          titleSpacing: 4.0,
          iconTheme: IconThemeData(
            color: Theme.of(context).primaryColor,
          ),
          backgroundColor: Colors.white,
          elevation: 1.0,
        ),
        body: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Name',
                      labelText: 'Name',
                    ),
                    controller: nameController,
                    onSaved: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Email',
                      labelText: 'Email',
                    ),
                    controller: emailController,
                    onSaved: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Phone',
                      labelText: 'Phone',
                    ),
                    controller: phoneController,
                    onSaved: (value) {
                      setState(() {
                        phone = value;
                      });
                    },
                    // initialValue: userSnapshot.data['Contact'],
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: locationService.getStates(),
                      builder: (context,
                          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                        if (snapshot.data != null) {
                          return DropDownFormField(
                            titleText: 'State',
                            hintText: 'Select State',
                            value: selectedState,
                            onSaved: (value) {
                              setState(() {
                                selectedState = value;
                                selectedDistrict = null;
                                selectedCity = null;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                selectedState = value;
                                selectedDistrict = null;
                                selectedCity = null;
                              });
                            },
                            dataSource: snapshot.data,
                            textField: 'Name',
                            valueField: 'Id',
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: locationService.getDistricts(selectedState),
                      builder: (context,
                          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                        if (snapshot.data != null) {
                          return DropDownFormField(
                            titleText: 'District',
                            hintText: 'Select District',
                            value: selectedDistrict,
                            onSaved: (value) {
                              setState(() {
                                selectedDistrict = value;
                                selectedCity = null;
                              });
                            },
                            onChanged: (value) {
                              print('OnChanged');
                              setState(() {
                                selectedDistrict = value;
                                selectedCity = null;
                              });
                              print('onChanged : $selectedDistrict');
                            },
                            dataSource: snapshot.data,
                            textField: 'Name',
                            valueField: 'Id',
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: locationService.getCities(
                          selectedState, selectedDistrict),
                      builder: (context,
                          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                        if (snapshot.data != null) {
                          return DropDownFormField(
                            titleText: 'City',
                            hintText: 'Select City',
                            value: selectedCity,
                            onSaved: (value) {
                              setState(() {
                                selectedCity = value;
                              });
                            },
                            onChanged: (value) {
                              print('OnChanged');

                              setState(() {
                                selectedCity = value;
                              });
                              print('onChanged : $selectedCity');
                            },
                            dataSource: snapshot.data,
                            textField: 'Name',
                            valueField: 'Id',
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: locationService.getPincode(
                        (selectedCity != null) ? selectedCity : '2'),
                    builder: (context,
                        AsyncSnapshot<List<Map<String, dynamic>>>
                            citySnapshot) {
                      if (citySnapshot.hasData) {
                        pincode = (citySnapshot.data[0]['Name'] != null)
                            ? citySnapshot.data[0]['Name']
                            : '';
                        return Container(
                          // child: TextFormField(
                          //   decoration: InputDecoration(
                          //     filled: true,
                          //     hintText: 'Pincode',
                          //     labelText: 'Pincode',
                          //   ),
                          //   initialValue: (citySnapshot.data[0]['Name'] != null)
                          //       ? citySnapshot.data[0]['Name']
                          //       : '',
                          //   controller: pincodeController,
                          // ),
                          height: 64.0,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            // borderRadius: BorderRadius.only(topLeft: Radius.circular(4.0), topRight: Radius.circular(4.0),),

                            border: Border(
                              bottom:
                                  BorderSide(width: 1.0, color: Colors.black54),
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text(
                                  'Pincode',
                                  style: Theme.of(context)
                                      .textTheme
                                      .body1
                                      .copyWith(
                                        color: Colors.grey.shade800,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w300,
                                      ),
                                ),
                                Text(
                                  (citySnapshot.data[0]['Name'] != null)
                                      ? citySnapshot.data[0]['Name']
                                      : '',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Address',
                      labelText: 'Address',
                    ),
                    maxLines: 5,
                    minLines: 3,
                    // expands: true,
                    controller: addressController,
                    onSaved: (value) {
                      setState(() {
                        address = value;
                      });
                    },
                    // initialValue: snapshot.data['Mobile'],
                  ),
                ),
              ],
            )),
        bottomNavigationBar: Container(
          child: RaisedButton(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'SUBMIT',
              style: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.title.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
            ),
            onPressed: () async {
              // if (_formKey.currentState.validate()) {
              //   _formKey.currentState.save();
              // _phoneController.text = '';
              // _passwordController.text = '';

              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              String userString = await sharedPreferences.get('user');

              name = nameController.text;
              email = emailController.text;
              phone = phoneController.text;
              address = addressController.text;

              Map<String, dynamic> user = await json.decode(userString);

              locationService
                  .getPincode((selectedCity != null) ? selectedCity : '2')
                  .then((data) {
                pincode = data[0]['Name'];

                print('Submitted Data');
                print('userId : $user["Id"]');
                print('Name : $name');
                print('Email : $email');
                print('Phone : $phone');
                print('State : $selectedState');
                print('District : $selectedDistrict');
                print('City : $selectedCity');
                print('Pincode : $pincode');
                print('Address : $address');

                cartService.placeOrder(user["Id"], name, email, phone, selectedState, selectedDistrict, selectedCity, address, pincode).then((data){

                  if(data['Success']){
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context){
                          return AlertDialog(
                              title: Text('SUCCESS'),
                              content: Text('Order is placed succesfully.'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('OK'),
                                  onPressed: (){
                                    Navigator.push(context, 
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(),
                                      ),
                                    );
                                    // Navigator.pop(context);
                                    // Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                        }
                      );
                  }else{
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context){
                          return AlertDialog(
                              title: Text('ERROR'),
                              content: Text(data['Message']),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('OK'),
                                  onPressed: (){
                                    Navigator.pop(context);
                                    // Navigator.pop(context);
                                    // Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                        }
                      );
                  }

                });
                
                // authService.updateUserProfile(
                //     user['Id'],
                //     name,
                //     email,
                //     phone,
                //     selectedState,
                //     selectedDistrict,
                //     selectedCity,
                //     pincode,
                //     address);
              });

              // _formKey.currentState.reset();
              // if(response['Success']){
              //   Navigator.push(context,
              //     MaterialPageRoute(
              //       builder: (context) => AuthenticationPage(),
              //     ),
              //   );
              // }
              // }
            },
          ),
        ),
      ),
    );
  }
}
