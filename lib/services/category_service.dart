import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoryService with ChangeNotifier {
  Future<List<Map<String, dynamic>>> getMainCategories() async {
    http.Response response = await http.get(
      'http://api.stationerymart.org/api/Home/Maincategorydata',
    );

    Map<String, dynamic> body = await json.decode(response.body);
    return [...body['Data']];
  }

  Future<List<Map<String, dynamic>>> getSubCategories(
      String mainCategoryId) async {
    http.Response response = await http.get(
      'http://api.stationerymart.org/api/Home/Subcategorydata?id=$mainCategoryId',
    );

    Map<String, dynamic> body = await json.decode(response.body);
    return [...body['Data']];
  }

  Future<List<Map<String, dynamic>>> getInSubCategories(
      String subCategoryId) async {
    http.Response response = await http.get(
      'http://api.stationerymart.org/api/Home/InSubcategorydata?id=$subCategoryId',
    );

    Map<String, dynamic> body = await json.decode(response.body);
    return [...body['Data']];
  }
}
