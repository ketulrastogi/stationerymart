import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stationerymart/pages/cagegories_page/categories_page.dart';

class CategoryItemWidget extends StatelessWidget {
  final String iconUrl, title, id;

  const CategoryItemWidget({Key key, this.iconUrl, this.title, this.id})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CategoriesPage(mainCategoryId: id,),),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: new Container(
          // margin: EdgeInsets.all(4.0),
          height: MediaQuery.of(context).size.width / 4.5,
          width: MediaQuery.of(context).size.width / 4.5,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Container(
                width: 48,
                height: 48,
                // padding: EdgeInsets.all(4.0),
                child: new SvgPicture.asset(
                  iconUrl,
                ),
              ),
              new Container(
                // padding: EdgeInsets.all(4.0),
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: GoogleFonts.roboto(
                    textStyle: Theme.of(context).textTheme.subtitle.copyWith(
                        color: Colors.blueGrey.shade700,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
