import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stationerymart/pages/authentication/authentication_page.dart';
import 'package:stationerymart/pages/manage_school_page/manage_school_page.dart';
import 'package:stationerymart/pages/my_orders_page/my_orders_page.dart';
import 'package:stationerymart/pages/school_wise_search_page/school_wise_search_page.dart';
import 'package:stationerymart/pages/shopping_cart_page/shopping_cart_page.dart';
import 'package:stationerymart/pages/user_profile_page/user_profile_page.dart';
import 'package:stationerymart/services/auth_service.dart';
import 'package:stationerymart/shared/carousel_slider_widget.dart';
import 'package:stationerymart/shared/categories_card.dart';
import 'package:stationerymart/shared/emergency_services_card_widget.dart';
import 'package:stationerymart/shared/repair_services_card_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final AuthService authService = Provider.of<AuthService>(context);

    return WillPopScope(
      onWillPop: (){
        exit(0);
        return;
      },
          child: SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text(
                'Stationary Mart',
                style: GoogleFonts.roboto(
                  textStyle: Theme.of(context).textTheme.headline.copyWith(
                      color: Colors.blueGrey.shade900,
                      fontWeight: FontWeight.bold),
                ),
              ),
              titleSpacing: 4.0,
              leading: InkWell(
                onTap: () => _scaffoldKey.currentState.openDrawer(),
                child: Container(
                  padding: EdgeInsets.all(18.0),
                  child: SvgPicture.asset(
                    'assets/icons/menu.svg',
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      size: 32.0,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShoppingCartPage(),
                        ),
                      );
                    },
                  ),
                ),
              ],
              iconTheme: IconThemeData(
                color: Theme.of(context).primaryColor,
              ),
              backgroundColor: Colors.white,
              elevation: 1.0,
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SchoolWiseSearchPage()),
                );
              },
            ),
            drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  // FutureBuilder<Map<String, dynamic>>(
                  //   future: authService.getUserDetails(),
                  //   builder: (context, snapshot) {
                  //     if(snapshot.hasData){
                  //       print(snapshot.data);
                  //       return UserAccountsDrawerHeader(
                  //         accountName: Text(
                  //           snapshot.data['Name'],
                  //           style: GoogleFonts.roboto(
                  //             textStyle: Theme.of(context)
                  //                 .textTheme
                  //                 .title
                  //                 .copyWith(color: Colors.white),
                  //           ),
                  //         ),
                  //         accountEmail: Text(
                  //           '+91${snapshot.data['Contact']}',
                  //           style: GoogleFonts.roboto(
                  //             textStyle: Theme.of(context)
                  //                 .textTheme
                  //                 .body1
                  //                 .copyWith(color: Colors.white),
                  //           ),
                  //         ),
                  //         currentAccountPicture: Icon(Icons.account_circle, size: 64.0,color: Colors.white,),
                  //         arrowColor: Colors.transparent,
                  //         onDetailsPressed: () {},
                  //       );
                  //     }else{
                  //       return Center(
                  //         child: CircularProgressIndicator(),
                  //       );
                  //     }
                  //   }
                  // ),
                  Container(
                    height: 200.0,
                    padding: EdgeInsets.all(16.0),
                    color: Colors.white,
                    child: Image.asset('assets/StationeryMartLogo.jpg'),
                  ),
                  // Divider(
                  // ),
                  ListTile(
                    leading: Container(
                        height: 24.0,
                        width: 24.0,
                        child: SvgPicture.asset('assets/icons/clipboard.svg')),
                    title: Text(
                      'My Orders',
                      style: GoogleFonts.roboto(
                        textStyle: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: Colors.blueGrey.shade800),
                      ),
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context)=> MyOrdersPage(),
                      ),);
                    },
                  ),
                  Divider(
                    indent: 64.0,
                  ),
                  ListTile(
                    leading: Container(
                        height: 24.0,
                        width: 24.0,
                        child: SvgPicture.asset('assets/icons/school.svg')),
                    title: Text(
                      'My Schools',
                      style: GoogleFonts.roboto(
                        textStyle: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: Colors.blueGrey.shade800),
                      ),
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context)=> ManageSchoolPage(),
                      ),);
                    },
                  ),
                  Divider(
                    indent: 64.0,
                  ),
                  ListTile(
                    leading: Container(
                        height: 24.0,
                        width: 24.0,
                        child: SvgPicture.asset('assets/icons/team.svg')),
                    title: Text(
                      'About Us',
                      style: GoogleFonts.roboto(
                        textStyle: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: Colors.blueGrey.shade800),
                      ),
                    ),
                  ),
                  Divider(
                    indent: 64.0,
                  ),
                  ListTile(
                    leading: Container(
                        height: 24.0,
                        width: 24.0,
                        child: SvgPicture.asset('assets/icons/contact.svg')),
                    title: Text(
                      'Contact Us',
                      style: GoogleFonts.roboto(
                        textStyle: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: Colors.blueGrey.shade800),
                      ),
                    ),
                  ),
                  
                  Divider(
                    indent: 64.0,
                  ),
                  ListTile(
                    leading: Container(
                        height: 24.0,
                        width: 24.0,
                        child: SvgPicture.asset('assets/icons/secure-data.svg')),
                    title: Text(
                      'Privacy Policy',
                      style: GoogleFonts.roboto(
                        textStyle: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: Colors.blueGrey.shade800),
                      ),
                    ),
                  ),
                  Divider(
                    indent: 64.0,
                  ),
                  ListTile(
                    onTap: () async{
                      await authService.signOut();
                      Navigator.push(context, 
                        MaterialPageRoute(
                          builder: (context) => AuthenticationPage()
                        ),
                      );
                    },
                    leading: Container(
                        height: 24.0,
                        width: 24.0,
                        child: SvgPicture.asset('assets/icons/logout.svg')),
                    title: Text(
                      'Logout',
                      style: GoogleFonts.roboto(
                        textStyle: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: Colors.blueGrey.shade800),
                      ),
                    ),
                  ),
                  Divider(
                    indent: 64.0,
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.blueGrey.shade50,
            body: ListView(
              padding: EdgeInsets.only(
                top: 8.0,
              ),
              children: <Widget>[
                CarouselSliderWidget(),
                SizedBox(
                  height: 8.0,
                ),
                ViewAllProductsWidget(),
                SizedBox(
                  height: 8.0,
                ),
                CategoriesCardWidget(),
                SizedBox(
                  height: 8.0,
                ),
                InkWell(
                    onTap: () {
                      // Navigator.push(context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ContactListPage(),
                      //   ),
                      // );
                    },
                    child: EmergencyServicesCardWidget()),
              ],
            )),
      ),
    );
  }
}
