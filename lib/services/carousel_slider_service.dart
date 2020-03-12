import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class CarouselSliderImage {
  final String id;
  final String name;
  final String image;

  CarouselSliderImage({this.id, this.name, this.image});

  factory CarouselSliderImage.fromJson(Map<String, dynamic> data) {
    // print(data['name']);
    return CarouselSliderImage(
        id: data['Id'],
        name: data['Name'],
        image: data['Image'],
        );
  }

}

class CarouselSliderService with ChangeNotifier{

  Future<List<CarouselSliderImage>> getSliderImages() async{
    http.Response response =
        await http.get('http://api.stationerymart.org/api/Home/Sliderdata');

    Map<String, dynamic> body = json.decode(response.body);

    return body['Data']
          .map<CarouselSliderImage>((item) {
          // print(item);
          return CarouselSliderImage.fromJson(item);
        })
        .toList();
  }

}