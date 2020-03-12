import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// cityGuide Icon Widget
class NewsPaper extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () {},
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 12.0),
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
                child: Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                      width: 48,
                      height: 48,
                      padding: EdgeInsets.all(4.0),
                      child: new SvgPicture.asset(
                        'assets/icons/team.svg',
                      ),
                    ),
              Expanded(
                flex: 1,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      child: new Padding(
                          padding: EdgeInsets.only(left: 18.0),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text(
                                'Newspapers',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              new Text('Humlog, Buniyad & More..'),
                            ],
                          )),
                    ),
                    Container(
                      width: 48,
                      height: 48,
                      padding: EdgeInsets.all(8.0),
                      child: new SvgPicture.asset(
                        'assets/icons/store.svg',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
