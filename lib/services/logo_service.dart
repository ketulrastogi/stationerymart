import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LogoService with ChangeNotifier {
  Future<List<Map<String, dynamic>>> getBrandList() async {
    http.Response response = await http.get(
      'http://api.stationerymart.org/api/Home/Branddata',
    );
    Map<String, dynamic> body = await json.decode(response.body);

    return [...body['Data']];
  }

  Future<List<Map<String, dynamic>>> getSchoolList() async {
    http.Response response = await http.get(
      'http://api.stationerymart.org/api/Home/Schooldata',
    );
    Map<String, dynamic> body = await json.decode(response.body);

    return [...body['Data']];
  }
}
