import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SchoolService with ChangeNotifier {


  Future<List<Map<String, dynamic>>> getSchools() async {
    http.Response response = await http.get(
      'http://api.stationerymart.org/api/Values/Schooldata',
    );

    Map<String, dynamic> body = await json.decode(response.body);
    return [...body['Data']];
  }

  Future<List<Map<String, dynamic>>> getBoards() async {
    http.Response response = await http.get(
      'http://api.stationerymart.org/api/Values/Boarddata',
    );

    Map<String, dynamic> body = await json.decode(response.body);
    return [...body['Data']];
  }

  Future<List<Map<String, dynamic>>> getMediums() async {
    http.Response response = await http.get(
      'http://api.stationerymart.org/api/Values/Mediumdata',
    );

    Map<String, dynamic> body = await json.decode(response.body);
    return [...body['Data']];
  }

  Future<List<Map<String, dynamic>>> getStandards() async {
    http.Response response = await http.get(
      'http://api.stationerymart.org/api/Values/Standarddata',
    );

    Map<String, dynamic> body = await json.decode(response.body);
    return [...body['Data']];
  }

}
