import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class LocationService with ChangeNotifier{

  Future<List<Map<String, dynamic>>> getStates() async{
    http.Response response = await http.get(
      'http://api.stationerymart.org/api/Values/Statedata',
    );

    Map<String, dynamic> body = await json.decode(response.body);
    return [...body['Data']];
  }

  Future<List<Map<String, dynamic>>> getDistricts(String stateId) async{
    if(stateId == null || stateId == ''){
      stateId = '2';
    }
    http.Response response = await http.get(
      'http://api.stationerymart.org/api/Values/Distictdata?id=$stateId',
    );

    Map<String, dynamic> body = await json.decode(response.body);
    return [...body['Data']];
  }

  Future<List<Map<String, dynamic>>> getCities(String stateId, String districtId) async{
    if(stateId == null || stateId == '' || districtId == null || districtId == ''){
      stateId = '2';
      districtId = '4';
    }
    http.Response response = await http.get(
      'http://api.stationerymart.org/api/Values/Citydata?id=$stateId&did=$districtId',
    );

    Map<String, dynamic> body = await json.decode(response.body);
    return [...body['Data']];
  }

  Future<List<Map<String, dynamic>>> getPincode(String cityId) async{
    
    http.Response response = await http.get(
      'http://api.stationerymart.org/api/Values/Pincodedata?id=$cityId',
    );

    Map<String, dynamic> body = await json.decode(response.body);
    return [...body['Data']];
  }

}