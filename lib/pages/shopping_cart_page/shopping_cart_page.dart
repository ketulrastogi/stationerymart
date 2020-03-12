import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stationerymart/pages/buyer_details_page/buyer_details_page.dart';
import 'package:stationerymart/services/cart_service.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  @override
  Widget build(BuildContext context) {
    CartService cartService = Provider.of<CartService>(context);

    return WillPopScope(
      onWillPop: (){
        Navigator.pop(context);
        // Navigator.pop(context);
        return;
      },
          child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Shopping Cart',
              style: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.headline.copyWith(
                    color: Colors.blueGrey.shade900, fontWeight: FontWeight.bold),
              ),
            ),
            titleSpacing: 4.0,
            iconTheme: IconThemeData(
              color: Theme.of(context).primaryColor,
            ),
            backgroundColor: Colors.white,
            elevation: 1.0,
          ),
          body: FutureBuilder<Map<String, dynamic>>(
              future: cartService.getCartProducts(),
              builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                    itemCount: [...snapshot.data['Data']].length,
                    itemBuilder: (context, index){
                      return ListTile(
                        leading: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            await cartService.deleteCartItem([...snapshot.data['Data']][index]['Id']);
                            setState(() {});
                          },
                        ),
                        title: Text([...snapshot.data['Data']][index]['Name'],
                          style: GoogleFonts.roboto(
                    textStyle: Theme.of(context).textTheme.subhead.copyWith(
                          color: Colors.blueGrey.shade900,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                        ),
                        subtitle: Text(
                            'Quantity : ${[...snapshot.data['Data']][index]['quetity']}    Price : ${[...snapshot.data['Data']][index]['totalprice']}',
                              style: GoogleFonts.roboto(
                    textStyle: Theme.of(context).textTheme.subtitle.copyWith(
                          color: Colors.blueGrey.shade700,
                          // fontWeight: FontWeight.bold,
                        ),
                  ),
                            ),
                      );
                    },
                    separatorBuilder: (context, index){
                      return Divider();
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          bottomNavigationBar: Container(
            height: 112.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Total Amount : ',
                          style: GoogleFonts.roboto(
                            textStyle: Theme.of(context)
                                .textTheme
                                .subhead
                                .copyWith(
                                    color: Colors.blueGrey.shade900,
                                    fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        child: FutureBuilder<Map<String, dynamic>>(
                            future: cartService.getCartProducts(),
                            builder: (context,
                                AsyncSnapshot<Map<String, dynamic>> snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data['TotalData'][0]['TotalPrice']
                                      .toString(),
                                  style: GoogleFonts.roboto(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .subhead
                                        .copyWith(
                                            color: Colors.blueGrey.shade900,
                                            fontWeight: FontWeight.bold),
                                  ),
                                );
                              } else {
                                return Center(
                                  child: Container(
                                      width: 24.0,
                                      height: 24.0,
                                      child: CircularProgressIndicator(),),
                                );
                              }
                            }),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: RaisedButton(
                    padding: EdgeInsets.all(16.0),
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'BUY NOW',
                      style: GoogleFonts.roboto(
                        textStyle: Theme.of(context).textTheme.title.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    onPressed: () {

                      Navigator.push(context, 
                        MaterialPageRoute(
                          builder: (context) => BuyerDetailsPage(),
                        ),
                      );

                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
