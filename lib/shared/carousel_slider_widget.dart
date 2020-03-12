import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stationerymart/services/carousel_slider_service.dart';

class CarouselSliderWidget extends StatefulWidget {

  @override
  _CarouselSliderWidgetState createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  List<String> sliderImages = [
    'https://image.freepik.com/free-vector/children-education_29937-3076.jpg',
    'https://image.freepik.com/free-vector/back-school-flat-design-illustration-with-backpack-trees_23-2148261825.jpg',
    'https://image.freepik.com/free-vector/children-education_29937-3076.jpg',
    // 'https://image.freepik.com/free-vector/business-consultant-thoughtful-man-working-laptop_1262-20611.jpg',
    // 'https://image.freepik.com/free-vector/vector-illustration-concept-plumber-service_81522-1000.jpg',
    // 'https://image.freepik.com/free-vector/group-medical-staff-carrying-health-related-icons_53876-43071.jpg',
    // 'https://image.freepik.com/free-vector/people-eating-junk-food_53876-66086.jpg'
  ];

  @override
  Widget build(BuildContext context) {

    final CarouselSliderService carouselSliderService = Provider.of<CarouselSliderService>(context);

    return FutureBuilder<List<CarouselSliderImage>>(
      future: carouselSliderService.getSliderImages(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return CarouselSlider(
          height: MediaQuery.of(context).size.height / 3,
          items: snapshot.data.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                              child: Container(
                    width: MediaQuery.of(context).size.width,
                    // decoration: BoxDecoration(
                    //   color: Colors.white,
                    //   borderRadius: BorderRadius.circular(8.0),
                    //   border: Border.all(color: Colors.blueGrey[50]),
                      
                    // ),
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(8.0),
                                    child: Image.network(
                          item.image, fit: BoxFit.fill, scale: 1.1,),
                    ),
                  ),
                );
              },
            );
          }).toList(),
          // aspectRatio: 16 / 9,
          viewportFraction: 0.95,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          pauseAutoPlayOnTouch: Duration(seconds: 10),
          enlargeCenterPage: true,
          onPageChanged: null,
          scrollDirection: Axis.horizontal,
        );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }
}
