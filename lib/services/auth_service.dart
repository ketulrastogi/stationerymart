import 'dart:math';

import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService with ChangeNotifier {
  String _phoneNumber;
  String _otp;
  String _smsAuthKey = '315981A7vZCG0w5e33fb8dP1';

  Future<bool> sendOtp(String phoneNumber) async {
    _otp = (Random().nextInt(900000) + 100000).toString();
    _phoneNumber = phoneNumber;
    notifyListeners();
    http.Response response = await http.get(
      'http://www.smsschool.in/api/otp.php?authkey=$_smsAuthKey&mobile=$_phoneNumber&message=Your%20otp%20is%20$_otp&sender=senderid&otp=$_otp',
    );
    Map<String, dynamic> body = await json.decode(response.body);
    if (body['type'] == 'success') {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> verifyOtp(String smsCode) async {
    if (smsCode == _otp) {
      http.Response response = await http.get(
          'http://api.stationerymart.org/api/profile/userprofile?mobile=$_phoneNumber');
      Map<String, dynamic> body = await json.decode(response.body);
      print('New User : $body');
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('user', response.body);

      if (body['Success']) {
        print('Mobile number is alreadt registered');

        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<Map<String, dynamic>> signIn(String username, String password) async {
    http.Response response = await http.post(
      'http://api.stationerymart.org/api/Login/Signin',
      body: {'username': username, 'password': password},
    );

    Map<String, dynamic> body = await json.decode(response.body);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('user', response.body);
    return body;
  }

  Future<Map<String, dynamic>> signUp(String fullName, String phoneNumber,
      String email, String password) async {
    http.Response response = await http.post(
      'http://api.stationerymart.org/api/Signup/Signup',
      body: {
        'Name': fullName,
        'Email': email,
        'Mobile': phoneNumber,
        'Password': password
      },
    );

    Map<String, dynamic> body = await json.decode(response.body);

    return body;
  }

  Future<Map<String, dynamic>> getUserDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, dynamic> user = {};
    // await sharedPreferences.setString('user', user.toString());
    String userString = await sharedPreferences.get('user');

    print('UserString : $userString');
    if (userString != null) {
      user = await json.decode(userString);
      return user;
    } else {
      user = {};
      return user;
    }
  }

  Future<void> updateUserProfile(
      String userId,
      String name,
      String email,
      String phone,
      String stateId,
      String districtId,
      String cityId,
      String pincode,
      String address) async {
    http.Response response = await http.post(
      'http://api.stationerymart.org/api/Profile/UpdateProfileDetail',
      body: {
        'Id': userId,
        'Name': name,
        'Email': email,
        'Contact': phone,
        'Country': 'India',
        'State': stateId,
        'Dist': districtId,
        'City': cityId,
        'Pincode': pincode,
        'Address': address,
      },
    );

    Map<String, dynamic> body = await json.decode(response.body);
    // print(body);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('user', response.body);
  }

  Future<void> signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, dynamic> user = {};
    await sharedPreferences.setString('user', user.toString());
  }
}
