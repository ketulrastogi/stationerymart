import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CartService with ChangeNotifier {
  Future<void> addToCart(List<Map<String, dynamic>> products) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, dynamic> user = json.decode(sharedPreferences.get('user'));
    print(user);
    products.forEach((product) {
      if (product['Selected']) {
        http.post('http://api.stationerymart.org/api/Pro/Addcart', body: {
          'memberid': user['Data'][0]['Id'],
          'Productid': product['Id'],
          'quetity': product['Quantity']
        });
        print(product);
      } else {
        print('product : ${product['Name']} is not selected');
      }
    });
  }

  Future<void> addToWebCart(List<Map<String, dynamic>> products) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, dynamic> user = json.decode(sharedPreferences.get('user'));
    print(user);
    print('AddToWebCart');

    // http.post('http://api.stationerymart.org/api/Pro/Addwebcart', body: {
    //       'memberid': user['Data'][0]['Id'],
    //       'ProductId': products[0]['Id'],
    //       'quetity': products[0]['Quantity'],
    //       'color': 'red',
    //       'size': '32',
    //     });

    products.forEach((product) {
      if (product['Selected']) {
        print(
            'MemberId: ${user['Data'][0]['Id']}, ProductId: ${product['Id']}, Quantity: ${product['Quantity']}');
        http.post('http://api.stationerymart.org/api/Pro/Addwebcart', body: {
          'memberid': user['Data'][0]['Id'],
          'ProductId': product['Id'],
          'quetity': product['Quantity'],
          'color': 'red',
          'size': '32',
        });
        // print(product);
      } else {
        // print('product : ${product['Name']} is not selected');
      }
    });
  }

  Future<Map<String, dynamic>> placeOrder(
      String userId,
      String name,
      String email,
      String phone,
      String stateId,
      String districtId,
      String cityId,
      String address,
      String pincode) async {
    print('MemberId: $userId');
    print('emailid : $email');
    print('shipstate : $stateId');
    http.Response response = await http.post(
      'http://api.stationerymart.org/api/Cart/PlaceOrder',
      body: {
        'MemberId': userId,
        'Name': name,
        'MobileNo': phone,
        'shipstate': stateId,
        'State': stateId,
        'Dist': districtId,
        'City': cityId,
        'Pincode': pincode,
        'SAZipcode': pincode,
        'ShippingAddress': address,
        // 'Address': address,
        'Country': 'India',
        'emailid': email,
      },
    );
    Map<String, dynamic> body = await json.decode(response.body);
    if (body['Success']) {
      print('Order is placed succesfully');
    } else {
      print('An Error occured while order placing');
    }
    print(body);
    return body;
  }

  Future<Map<String, dynamic>> placeWebOrder(
      String userId,
      String name,
      String email,
      String phone,
      String stateId,
      String districtId,
      String cityId,
      String address,
      String pincode) async {
    print('MemberId: $userId');
    print('emailid : $email');
    print('shipstate : $stateId');
    http.Response response = await http.post(
      'http://api.stationerymart.org/api/Cart/PlaceWebOrder',
      body: {
        'MemberId': userId,
        'Name': name,
        'MobileNo': phone,
        'shipstate': stateId,
        'State': stateId,
        'Dist': districtId,
        'City': cityId,
        'Pincode': pincode,
        'SAZipcode': pincode,
        'ShippingAddress': address,
        // 'Address': address,
        'Country': 'India',
        'emailid': email,
      },
    );
    Map<String, dynamic> body = await json.decode(response.body);
    if (body['Success']) {
      print('Order is placed succesfully');
    } else {
      print('An Error occured while order placing');
    }
    print(body);
    return body;
  }

  // Future<List<Map<String, dynamic>>> getAllProducts() async{
  //   http.Response response = await http.get(
  //       'http://api.stationerymart.org/api/Cart/Cartdata?mid=${user['Id']}');
  // }

  Future<Map<String, dynamic>> getCartProducts() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Map<String, dynamic> user = json.decode(sharedPreferences.get('user'));
    print('UserID : ${user['Data'][0]['Id']}');
    http.Response response = await http.get(
        'http://api.stationerymart.org/api/Cart/Cartdata?mid=${user['Data'][0]['Id']}');

    Map<String, dynamic> body = await json.decode(response.body);

    return body;
  }

  Future<Map<String, dynamic>> getWebCartProducts() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Map<String, dynamic> user = json.decode(sharedPreferences.get('user'));
    print('UserID : ${user['Data'][0]['Id']}');
    http.Response response = await http.get(
        'http://api.stationerymart.org/api/Cart/Webcartdata?mid=${user['Data'][0]['Id']}');

    Map<String, dynamic> body = await json.decode(response.body);

    return body;
  }

  Future<void> deleteCartItem(String itemId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Map<String, dynamic> user = json.decode(sharedPreferences.get('user'));

    http.Response response = await http.get(
        'http://api.stationerymart.org/api/Cart/DeleteCart?mid=${user['Data'][0]['Id']}&id=$itemId');
  }

  Future<List<Map<String, dynamic>>> getMyOrders() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Map<String, dynamic> user = json.decode(sharedPreferences.get('user'));

    http.Response response = await http.get(
        'http://api.stationerymart.org/api/Cart/Orderdata?mid=${user['Data'][0]['Id']}');

    Map<String, dynamic> body = await json.decode(response.body);

    return [...body['Data']];
  }

  Future<List<Map<String, dynamic>>> getMainCategories() async {
    http.Response response = await http
        .get('http://api.stationerymart.org/api/Home/Maincategorydata');

    Map<String, dynamic> body = await json.decode(response.body);

    return [...body['Data']];
  }

  Future<List<Map<String, dynamic>>> getSubCategories(
      String mainCategoryId) async {
    if (mainCategoryId == null || mainCategoryId == '') {
      mainCategoryId = '1';
    }

    http.Response response = await http.get(
        'http://api.stationerymart.org/api/Home/Subcategorydata?id=$mainCategoryId');

    Map<String, dynamic> body = await json.decode(response.body);
    return [...body['Data']];
  }

  Future<List<Map<String, dynamic>>> getInSubCategories(
      String subCategoryId) async {
    if (subCategoryId == null) {
      subCategoryId = '5';
    }

    http.Response response = await http.get(
        'http://api.stationerymart.org/api/Home/InSubcategorydata?id=$subCategoryId');

    Map<String, dynamic> body = await json.decode(response.body);
    return [...body['Data']];
  }

  Future<List<Map<String, dynamic>>> getProductsForCategory(
      String inSubCategoryId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, dynamic> user = json.decode(sharedPreferences.get('user'));
    http.Response response = await http.get(
        'http://api.stationerymart.org/api/Undersub/Undersubdata?id=$inSubCategoryId&mid=${user['Data'][0]['Id']}');

    Map<String, dynamic> body = await json.decode(response.body);
    print('UserId : ${user['Data'][0]['Id']}');
    print('InSubCategoryId: $inSubCategoryId');
    print('Data : ${body['Data']}');
    return [...body['Data']];
  }
}
