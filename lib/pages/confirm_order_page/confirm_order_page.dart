import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stationerymart/pages/school_wise_search_page/school_wise_search_page.dart';
import 'package:stationerymart/services/auth_service.dart';
import 'package:stationerymart/services/cart_service.dart';

class ConfirmOrderPage extends StatefulWidget {

  final List<Map<String, dynamic>> products;

  const ConfirmOrderPage({Key key, this.products}) : super(key: key);

  @override
  _ConfirmOrderPageState createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {

  
  @override
  Widget build(BuildContext context) {


    CartService cartService = Provider.of<CartService>(context);
    AuthService authService = Provider.of<AuthService>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Confirm Order',
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
          future: authService.getUserDetails(),
          builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if(snapshot.hasData){
              return ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Name',
                      labelText: 'Name',
                    ),
                    initialValue: snapshot.data['Name'],
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Email',
                      labelText: 'Email',
                    ),
                    initialValue: snapshot.data['Email'],
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Phone',
                      labelText: 'Phone',
                    ),
                    initialValue: snapshot.data['Mobile'],
                  ),
                ),
                // SizedBox(
                //   height: 8.0,
                // ),
                // Container(
                //   child: TextFormField(
                //     decoration: InputDecoration(
                //       filled: true,
                //       hintText: 'Pincode',
                //       labelText: 'Pincode',
                //     ),
                //   ),
                // ),
              ],
            );
            }else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        ),
        bottomNavigationBar: Container(
                  child: RaisedButton(
                    child: Text(
                      'CONFIRM',
                      style: GoogleFonts.roboto(
                        textStyle: Theme.of(context).textTheme.title.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    padding: EdgeInsets.all(16.0),
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(8.0)),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context){
                          return AlertDialog(
                              title: Text('SUCCESS'),
                              content: Text('Order is placed succesfully.'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('OK'),
                                  onPressed: (){

                                    // print(widget.products);

                                    cartService.addToCart(widget.products);

                                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                      builder: (context) => SchoolWiseSearchPage(),
                                    ), ModalRoute.withName('/schoolwisesearch'),);
                                  },
                                ),
                              ],
                            );
                        }
                      );
                    },
                  ),
                ),
      ),
    );
  }
}