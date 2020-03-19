import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stationerymart/pages/package_items_page/package_items_page.dart';
import 'package:stationerymart/services/product_service.dart';
import 'package:stationerymart/services/school_service.dart';

class SchoolWiseSearchPage extends StatefulWidget {
  @override
  _SchoolWiseSearchPageState createState() => _SchoolWiseSearchPageState();
}

class _SchoolWiseSearchPageState extends State<SchoolWiseSearchPage> {
  

  String _selectedSchool;
  String _selectedBoard;
  String _selectedMedium;
  String _selectedStandard;

  @override
  Widget build(BuildContext context) {
    ProductService _productService = Provider.of<ProductService>(context);
    SchoolService _schoolService = Provider.of<SchoolService>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'School Wise Search',
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
        body: Center(
          child: Form(
            // key: formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: <Widget>[
                Container(
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: _schoolService.getSchools(),
                      builder: (context,
                          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                        if (snapshot.data != null) {
                          return DropDownFormField(
                            titleText: 'School',
                            hintText: 'Select School',
                            value: _selectedSchool,
                            onSaved: (value) {
                              setState(() {
                                _selectedSchool = value;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                _selectedSchool = value;
                              });
                            },
                            dataSource: snapshot.data,
                            textField: 'Name',
                            valueField: 'Id',
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: _schoolService.getBoards(),
                      builder: (context,
                          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                        if (snapshot.hasData) {
                          return DropDownFormField(
                            titleText: 'Board',
                            hintText: 'Select Board',
                            value: _selectedBoard,
                            onSaved: (value) {
                              setState(() {
                                _selectedBoard = value;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                _selectedBoard = value;
                              });
                            },
                            dataSource: snapshot.data,
                            textField: 'Name',
                            valueField: 'Id',
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: _schoolService.getMediums(),
                      builder: (context,
                          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                        if (snapshot.hasData) {
                          return DropDownFormField(
                            titleText: 'Medium',
                            hintText: 'Select Medium',
                            value: _selectedMedium,
                            onSaved: (value) {
                              setState(() {
                                _selectedMedium = value;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                _selectedMedium = value;
                              });
                            },
                            dataSource: snapshot.data,
                            textField: 'Name',
                            valueField: 'Id',
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: _schoolService.getStandards(),
                      builder: (context,
                          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                        if (snapshot.hasData) {
                          return DropDownFormField(
                            titleText: 'Standard',
                            hintText: 'Select Standard',
                            value: _selectedStandard,
                            onSaved: (value) {
                              setState(() {
                                _selectedStandard = value;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                _selectedStandard = value;
                              });
                            },
                            dataSource: snapshot.data,
                            textField: 'Name',
                            valueField: 'Id',
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
                SizedBox(
                  height: 8,
                ),

                // Container(
                //   padding: EdgeInsets.all(16),
                //   child: Text(_selectedSchool['display']),
                // )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          child: RaisedButton(
            child: Text(
              'SUBMIT',
              style: GoogleFonts.roboto(
                textStyle: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            padding: EdgeInsets.all(16.0),
            // shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(8.0)),
            color: Theme.of(context).primaryColor,
            onPressed: () async {
              List<Map<String, dynamic>> data =
                  await _productService.getSchoolWiseProducts(
                      _selectedSchool, _selectedBoard, _selectedMedium, _selectedStandard);
              List<Map<String, dynamic>> products = [];
              data.forEach((product){
                products.add(
                  {
                    'Id': product['Id'],
                    'Name': product['Name'],
                    'Price': product['Price'],
                    'Quantity': '1',
                    'Selected': true,
                  }
                );
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PackageItemsPage(
                    products: products,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
