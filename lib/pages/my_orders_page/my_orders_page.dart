import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stationerymart/services/cart_service.dart';

class MyOrdersPage extends StatefulWidget {
  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  @override
  Widget build(BuildContext context) {
    CartService cartService = Provider.of<CartService>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'My Orders',
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
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: cartService.getMyOrders(),
          builder:
              (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index){
                  Map<String, dynamic> item = snapshot.data[index];
                  return Wrap(
                    children: <Widget>[
                      OrderFieldValueContainer(id: 'Name', value: item['Name']),
                      OrderFieldValueContainer(
                          id: 'Status', value: item['Status']),
                      OrderFieldValueContainer(
                          id: 'Bill Amount', value: item['Billamount']),
                      OrderFieldValueContainer(
                          id: 'Payment Type', value: item['PaymentType']),
                      OrderFieldValueContainer(
                          id: 'Order Date', value: item['Date']),
                    ],
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
          },
        ),
      ),
    );
  }
}

class OrderFieldValueContainer extends StatelessWidget {
  final String id;
  final String value;

  const OrderFieldValueContainer({Key key, this.id, this.value})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            id,
            style: GoogleFonts.roboto(
              textStyle: Theme.of(context).textTheme.subtitle.copyWith(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.roboto(
              textStyle: Theme.of(context).textTheme.subhead.copyWith(
                    color: Colors.blueGrey.shade900,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
