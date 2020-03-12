import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

showDrawer(){
  Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('Ketul Rastogi'),
                accountEmail: Text('ketul.rastogi@gmail.com'),
                currentAccountPicture: SvgPicture.asset('assets/female.svg'),
                onDetailsPressed: (){},
              ),
              ListTile(
                leading: Container(
                  height: 24.0,
                  width: 24.0,
                  child: SvgPicture.asset('assets/icons/house.svg')),
                title: Text('Home'),
              ),
              Divider(
                indent: 64.0,
              ),
              ListTile(
                leading: Container(
                  height: 24.0,
                  width: 24.0,
                  child: SvgPicture.asset('assets/icons/house.svg')),
                title: Text('Home'),
              ),
              ListTile(
                leading: Container(
                  height: 24.0,
                  width: 24.0,
                  child: SvgPicture.asset('assets/icons/house.svg')),
                title: Text('Home'),
              ),
            ],
          ),
        );
}