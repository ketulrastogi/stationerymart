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
      print(product);
      if (product['Selected']) {
        http.post('http://api.stationerymart.org/api/Pro/Addcart', body: {
          'memberid': user['Id'],
          'Productid': product['Id'],
          'quetity': product['Quantity']
        });
      } else {
        print('product : ${product['Name']} is not selected');
      }
    });
  }

  Future<Map<String, dynamic>> placeOrder(String userId, String name, String email, String phone, String stateId, String districtId, String cityId, String address, String pincode) async{
    print('MemberId: $userId');
    print('emailid : $email');
    print('shipstate : $stateId');
    http.Response response =
        await http.post('http://api.stationerymart.org/api/Cart/PlaceWebOrder',
          body:{
            'MemberId': userId,
            'Name' : name,
            'MobileNo' : phone,
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
    if(body['Success']){
      print('Order is placed succesfully');
    }else{
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

    http.Response response = await http.get(
        'http://api.stationerymart.org/api/Cart/Cartdata?mid=${user['Id']}');

    Map<String, dynamic> body = await json.decode(response.body);

    return body;
  }

  Future<void> deleteCartItem(String itemId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Map<String, dynamic> user = json.decode(sharedPreferences.get('user'));

    http.Response response = await http.get(
        'http://api.stationerymart.org/api/Cart/DeleteCart?mid=${user['Id']}&id=$itemId');
  }

  Future<List<Map<String, dynamic>>> getMyOrders() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Map<String, dynamic> user = json.decode(sharedPreferences.get('user'));

    http.Response response = await http.get(
        'http://api.stationerymart.org/api/Cart/Orderdata?mid=${user['Id']}');

    Map<String, dynamic> body = await json.decode(response.body);

    return [...body['Data']];
  }


  Future<List<Map<String, dynamic>>> getMainCategories() async{

    http.Response response = await http.get(
        'http://api.stationerymart.org/api/Home/Maincategorydata');

    Map<String, dynamic> body = await json.decode(response.body);

    return [...body['Data']];

  }

  Future<List<Map<String, dynamic>>> getSubCategories(String mainCategoryId) async{

    if(mainCategoryId == null || mainCategoryId == ''){
      mainCategoryId = '1';
    }

    http.Response response = await http.get(
        'http://api.stationerymart.org/api/Home/Subcategorydata?id=$mainCategoryId');

    Map<String, dynamic> body = await json.decode(response.body);
    return [...body['Data']];
  }

  Future<List<Map<String, dynamic>>> getInSubCategories(String subCategoryId) async{

    if(subCategoryId == null){
      subCategoryId = '5';
    }

    http.Response response = await http.get(
        'http://api.stationerymart.org/api/Home/InSubcategorydata?id=$subCategoryId');

    Map<String, dynamic> body = await json.decode(response.body);
    return [...body['Data']];
  }

  Future<List<Map<String, dynamic>>> getProductsForCategory(String inSubCategoryId) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, dynamic> user = json.decode(sharedPreferences.get('user'));
    http.Response response = await http.get(
        'http://api.stationerymart.org/api/Undersub/Undersubdata?id=$inSubCategoryId&mid=${user['Id']}');

    Map<String, dynamic> body = await json.decode(response.body);
    return [...body['Data']];
  }
}
