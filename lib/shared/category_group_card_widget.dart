import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stationerymart/shared/category_item.dart';

class CategoryGroupCardWidget extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const CategoryGroupCardWidget({Key key, this.items}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    var height = ((items.length ~/ 4).toInt()) * 100.0 +
        (((items.length % 4) > 0) ? 1 : 0) * 100.0;
    print('Height : $height');

    return Card(

          margin: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 12.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Container(
            height: height + 52.0,
            child: Column(
        

              children: <Widget>[
                Container(
                  
                  padding: EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Repair',
                      style: GoogleFonts.roboto(
                        textStyle: Theme.of(context).textTheme.title.copyWith(
                              color: Colors.blueGrey.shade800,
                            ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: height,
                  padding: EdgeInsets.only(top: 4.0),
                  child: GridView.count(
                    physics : NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
primary: true,
                    crossAxisCount: 4,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    children: items.map((item) {
                      return CategoryItemWidget(
                        title: item['title'],
                        iconUrl: item['iconUrl'],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
  }
}