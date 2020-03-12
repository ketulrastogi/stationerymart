import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stationerymart/pages/authentication/authentication_page.dart';
import 'package:stationerymart/pages/school_wise_search_page/school_wise_search_page.dart';
import 'package:stationerymart/services/auth_service.dart';
import 'package:stationerymart/services/carousel_slider_service.dart';
import 'package:stationerymart/services/cart_service.dart';
import 'package:stationerymart/services/location_service.dart';
import 'package:stationerymart/services/product_service.dart';
import 'package:stationerymart/services/school_service.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
          providers: [
            ChangeNotifierProvider<CarouselSliderService>(
              create: (context) => CarouselSliderService(),
            ),
            ChangeNotifierProvider<AuthService>(
              create: (context) => AuthService(),
            ),
            ChangeNotifierProvider<LocationService>(
              create: (context) => LocationService(),
            ),
            ChangeNotifierProvider<SchoolService>(
              create: (context) => SchoolService(),
            ),
            ChangeNotifierProvider<ProductService>(
              create: (context) => ProductService(),
            ),
            ChangeNotifierProvider<CartService>(
              create: (context) => CartService(),
            ),
          ],
          child: MaterialApp(
        title: 'Stationery Mart',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        // home: HomePage(),
        // home: AuthenticationPage(),
        initialRoute: '/',
        routes: {
          '/': (context) => AuthenticationPage(),
          '/schoolwisesearch': (context) => SchoolWiseSearchPage(),
          // '/myorders': (context) => MyOrdersPage(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text('Stationary Mart'),
      ),
      
    );
  }
}
