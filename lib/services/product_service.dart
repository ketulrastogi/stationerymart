import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class ProductService with ChangeNotifier {

  List<Map<String, dynamic>> products = [
      {
        'id': '23',
        'name': 'Art and Creativity',
        'price': '160',
        'quantity': '1',
        'selected': true,
      },
      {
        'id': '22',
        'name': 'My Maths Activity',
        'price': '135',
        'quantity': '1',
        'selected': true,
      },
      {
        'id': '21',
        'name': 'Rhymes Fable',
        'price': '85',
        'quantity': '1',
        'selected': true,
      },
      {
        'id': '20',
        'name': 'Colour me',
        'price': '75',
        'quantity': '1',
        'selected': true,
      },
      {
        'id': '19',
        'name': 'My Picture Dictionary',
        'price': '124',
        'quantity': '1',
        'selected': true,
      },
      
    ];

    List<Map<String, dynamic>> _products = [];
    

  Future<List<Map<String, dynamic>>> getSchoolWiseProducts(String schoolId, String boardId, String mediumId, String standardId) async{
    http.Response response =
        await http.get('http://api.stationerymart.org/api/Values/ViewProductData?sid=$schoolId&bid=$boardId&mid=$mediumId&stid=$standardId',);
    Map<String, dynamic> body = await json.decode(response.body);
    // print('School Data : ${body['Data']}');
    return [...body['Data']];
  }

  Future<List<Map<String, dynamic>>> updateProduct(Map<String, dynamic> product) async{

    _products.map((p){
      if(p['id'] == product['id']){
        return product;
      }
      return p;
    });

    return _products;

  }

}