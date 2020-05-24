import 'package:flutter/material.dart';
import 'package:stationerymart/shared/category_item.dart';

class CategoriesCardWidget extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {
      'iconUrl': 'assets/icons/school_stationary.svg',
      'title': 'School Stationary',
      'id': '1',
    },
    {
      'iconUrl': 'assets/icons/office_stationary.svg',
      'title': 'Office Stationary',
      'id': '2',
    },
    {
      'iconUrl': 'assets/icons/other_stationary.svg',
      'title': 'Other Stationary',
      'id': '3',
    },
    // {
    //   'iconUrl': 'assets/icons/entertainment.svg',
    //   'title': 'Entertainment',
    // },
    // {
    //   'iconUrl': 'assets/icons/consultant.svg',
    //   'title': 'Consultants',
    // },
    // {
    //   'iconUrl': 'assets/icons/office.svg',
    //   'title': 'Offices',
    // },
    // {
    //   'iconUrl': 'assets/icons/shop.svg',
    //   'title': 'Shops',
    // },
    // {
    //   'iconUrl': 'assets/icons/more.svg',
    //   'title': 'More',
    // }
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.0,
      margin: EdgeInsets.symmetric(horizontal: 12.0),
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: items.map((item) {
          return CategoryItemWidget(
              title: item['title'], iconUrl: item['iconUrl'], id: item['id']);
        }).toList(),
      ),
    );
  }
}
