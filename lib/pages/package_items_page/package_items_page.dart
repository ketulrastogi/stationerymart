import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stationerymart/pages/confirm_order_page/confirm_order_page.dart';
import 'package:stationerymart/pages/shopping_cart_page/shopping_cart_page.dart';
import 'package:stationerymart/services/cart_service.dart';

class PackageItemsPage extends StatefulWidget {
  final List<Map<String, dynamic>> products;
  final bool isWebProduct;

  const PackageItemsPage({Key key, this.products, this.isWebProduct})
      : super(key: key);
  @override
  _PackageItemsPageState createState() => _PackageItemsPageState();
}

class _PackageItemsPageState extends State<PackageItemsPage> {
  bool _selected = false;
  int total = 0;
  List<Map<String, dynamic>> products = [];
  @override
  void initState() {
    super.initState();
    // products.addAll([...widget.products]);
    // print('widget products : ${widget.products}');
    widget.products.forEach((product) {
      products.add(product);
    });
    // print('products : $products');
  }

  increaseQuantity(Map<String, dynamic> product) {
    int index = products.indexWhere((item) => (item['Id'] == product['Id']));
    setState(() {
      products[index]['Quantity'] =
          (int.parse(products[index]['Quantity']) + 1).toString();
    });
  }

  decreaseQuantity(Map<String, dynamic> product) {
    int index = products.indexWhere((item) => (item['Id'] == product['Id']));
    if (int.parse(products[index]['Quantity']) > 1) {
      setState(() {
        products[index]['Quantity'] =
            (int.parse(products[index]['Quantity']) - 1).toString();
        // products[index]['price'] = (int.parse(widget.products[index]['price']) * int.parse(products[index]['quantity'])).toString();
      });
    } else if (int.parse(products[index]['Quantity']) == 1) {
      setState(() {
        _selected = false;
        product['Selected'] = false;
        products[index]['Quantity'] =
            (int.parse(products[index]['Quantity']) - 1).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    CartService cartService = Provider.of<CartService>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Product List',
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
        body: ListView.separated(
          itemCount: products.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> product = products[index];
            String _id;
            String _name;
            String _price;
            String _quantity;
            bool _selected;

            _id = product['Id'];
            _name = product['Name'];
            _price = product['Price'];
            _quantity = product['Quantity'];
            _selected = product['Selected'];

            // print(product);

            return ListTile(
              // leading: Checkbox(
              //   value: _selected,
              //   onChanged: (bool value) {
              //     setState(() {
              //       _selected = value;
              //       product['Selected'] = value;
              //     });
              //   },
              // ),
              leading: Container(
                height: 64.0,
                width: 64.0,
                child: Image.network(product['Image']),
              ),
              title: Text(
                product['Name'],
                style: GoogleFonts.roboto(
                  textStyle: Theme.of(context).textTheme.subhead.copyWith(
                        color: Colors.blueGrey.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              subtitle: Text(
                'Price : ${(int.parse(product['Price']))}',
                style: GoogleFonts.roboto(
                  textStyle: Theme.of(context).textTheme.subtitle.copyWith(
                        color: Colors.blueGrey.shade700,
                        // fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              trailing: Container(
                width: 80.0,
                child: (_quantity == '0')
                    ? Checkbox(
                        value: _selected,
                        onChanged: (bool value) {
                          setState(() {
                            _selected = value;
                            product['Selected'] = value;
                            increaseQuantity(product);
                          });
                        },
                      )
                    : Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              increaseQuantity(product);
                            },
                            child: Container(
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.all(0.0),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 6.0,
                          ),
                          Container(
                            width: 16.0,
                            child: Center(
                              child: Text(_quantity),
                            ),
                          ),
                          SizedBox(
                            width: 6.0,
                          ),
                          InkWell(
                            onTap: () {
                              decreaseQuantity(product);
                            },
                            child: Container(
                              child: Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.all(0.0),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        ),
        bottomNavigationBar: RaisedButton(
          child: Text(
            'ADD TO CART',
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
            // print('Error Printing');
            // print('Products : $products');
            if (widget.isWebProduct) {
              await cartService.addToWebCart(widget.products);
            } else {
              await cartService.addToCart(widget.products);
            }

            showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) {
                  return AlertDialog(
                    title: Text('SUCCESS'),
                    content: Text('Products are added to cart succesfully.'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('OK'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShoppingCartPage(),
                            ),
                          );
                          // Navigator.pop(context);
                          // Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                });
          },
        ),
      ),
    );
  }
}
