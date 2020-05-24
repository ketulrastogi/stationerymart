import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stationerymart/services/cart_service.dart';
import 'package:provider/provider.dart';
import 'package:stationerymart/pages/package_items_page/package_items_page.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

class CategoriesPage extends StatefulWidget {
  final String mainCategoryId;

  const CategoriesPage({Key key, this.mainCategoryId}) : super(key: key);
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  String selectedSubCategory;
  String selectedInSubCategory;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CartService cartService = Provider.of<CartService>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Categories',
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
        body: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            Container(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: cartService.getSubCategories(widget.mainCategoryId),
                  builder: (context,
                      AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.data != null) {
                      return DropDownFormField(
                        titleText: 'Sub Category',
                        hintText: 'Select Sub Category',
                        value: selectedSubCategory,
                        onSaved: (value) {
                          setState(() {
                            selectedSubCategory = value;
                            selectedInSubCategory = null;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            selectedSubCategory = value;
                            selectedInSubCategory = null;
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
                  initialData: [],
                  future: cartService.getInSubCategories(selectedSubCategory),
                  builder: (context,
                      AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.data != null) {
                      return DropDownFormField(
                        titleText: 'In Sub Category',
                        hintText: 'Select In Sub Category',
                        value: selectedInSubCategory,
                        onSaved: (value) {
                          setState(() {
                            selectedInSubCategory = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            selectedInSubCategory = value;
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
          ],
        ),
        bottomNavigationBar: Container(
          child: RaisedButton(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'SUBMIT',
              style: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.title.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
            ),
            onPressed: () async {
              cartService
                  .getProductsForCategory(selectedInSubCategory)
                  .then((data) {
                List<Map<String, dynamic>> products = [];
                data.forEach((product) {
                  print(product['offerprice'].toString());
                  products.add({
                    'Id': product['Id'],
                    'Name': product['Name'],
                    // 'Price': '10',
                    'Price':
                        num.parse(product['offerprice']).round().toString(),
                    'Quantity': '1',
                    'Selected': false,
                  });
                });

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PackageItemsPage(
                      products: products,
                    ),
                  ),
                );
              });
            },
          ),
        ),
      ),
    );
  }
}
