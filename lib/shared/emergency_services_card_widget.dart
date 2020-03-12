import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class EmergencyServicesCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        padding: EdgeInsets.all(12.0),
        child: Row(
          children: <Widget>[
            Container(
              width: 48,
              height: 48,
              padding: EdgeInsets.all(4.0),
              child: SvgPicture.asset(
                'assets/icons/shoe.svg',
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(left:12.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Shoes & Accessories',
                        style: GoogleFonts.roboto(
                          textStyle: Theme.of(context).textTheme.subhead.copyWith(
                              color: Colors.blueGrey.shade900,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      
                    ],
                  ),
              ),
            ),
            Container(
              width: 48,
              height: 48,
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: SvgPicture.asset(
                'assets/icons/arrows.svg',
              ),
            ),
          ],
        ),
      ),
    );
  }
}