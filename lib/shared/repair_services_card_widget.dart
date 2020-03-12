import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stationerymart/pages/all_product_list_page/all_product_list_page.dart';
import 'package:stationerymart/services/cart_service.dart';

class ViewAllProductsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    CartService cartService = Provider.of<CartService>(context);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: () async{

          Navigator.push(context, 
            MaterialPageRoute(
              builder: (context) => AllProductListPage(),
            ),
          );
        },
              child: Container(
          padding: EdgeInsets.all(12.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 48,
                height: 48,
                padding: EdgeInsets.all(4.0),
                child: SvgPicture.asset(
                  'assets/icons/book.svg',
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Books & E-Learning',
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
      ),
    );
  }
}
