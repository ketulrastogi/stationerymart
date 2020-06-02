import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stationerymart/pages/package_items_page/package_items_page.dart';
import 'package:stationerymart/services/cart_service.dart';
import 'package:stationerymart/services/category_service.dart';

class AllCategoriesCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CategoryService _categoryService =
        Provider.of<CategoryService>(context);
    return Container(
      child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _categoryService.getMainCategories(),
          builder:
              (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return MainCategoryWidget(
                    mainCategory: snapshot.data[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 8.0,
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

class MainCategoryWidget extends StatelessWidget {
  final Map<String, dynamic> mainCategory;

  const MainCategoryWidget({Key key, this.mainCategory}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final CategoryService _categoryService =
        Provider.of<CategoryService>(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              mainCategory['Name'],
              style: GoogleFonts.roboto(
                textStyle: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(color: Colors.blueGrey.shade800),
              ),
            ),
          ),
          Container(
            child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _categoryService.getSubCategories(mainCategory['Id']),
                builder: (context,
                    AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return SubCategoryWidget(
                          subCategory: snapshot.data[index],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 8.0,
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}

class SubCategoryWidget extends StatelessWidget {
  final Map<String, dynamic> subCategory;

  const SubCategoryWidget({Key key, this.subCategory}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final CategoryService _categoryService =
        Provider.of<CategoryService>(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              subCategory['Name'],
              style: GoogleFonts.roboto(
                textStyle: Theme.of(context)
                    .textTheme
                    .subhead
                    .copyWith(color: Colors.blueGrey.shade800),
              ),
            ),
          ),
          Container(
            height: 120.0,
            child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _categoryService.getInSubCategories(subCategory['Id']),
                builder: (context,
                    AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                      // shrinkWrap: true,
                      // primary: false,
                      padding:
                          EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return CategoryWidget(
                          inSubCategory: snapshot.data[index],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: 8.0,
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  final Map<String, dynamic> inSubCategory;

  const CategoryWidget({Key key, this.inSubCategory}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final CartService _cartService = Provider.of<CartService>(context);
    return Card(
      margin: EdgeInsets.all(0.0),
      child: InkWell(
        onTap: () {
          // print('InSubCategory : ${(inSubCategory['Id'])}');
          _cartService.getProductsForCategory(inSubCategory['Id']).then((data) {
            List<Map<String, dynamic>> products = [];
            data.forEach((product) {
              // print('Id: ${product['Id']}, Image: ${product['Images']}');
              products.add({
                'Id': product['Id'],
                'Name': product['Name'],
                // 'Price': '10',
                'Image': (product['Images'].length == 0)
                    ? 'http://stationerymart.org/upload/Websetting/Header/175Stationery%20Mart.jpg'
                    : product['Images'][0]['image'],
                'Price': num.parse(product['offerprice']).round().toString(),
                'Quantity': '0',
                'Selected': false,
              });
            });

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PackageItemsPage(
                  products: products,
                  isWebProduct: true,
                ),
              ),
            );
          });
        },
        child: Container(
          height: 120.0,
          width: 120.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                // padding: EdgeInsets.all(8.0),
                height: 64.0,
                width: 64.0,
                child: Image.network(
                  inSubCategory['image'],
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  inSubCategory['Name'].toString().trim(),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
