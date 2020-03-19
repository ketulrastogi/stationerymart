import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stationerymart/services/school_service.dart';

class ManageSchoolPage extends StatefulWidget {
  @override
  _ManageSchoolPageState createState() => _ManageSchoolPageState();
}

class _ManageSchoolPageState extends State<ManageSchoolPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name;
  String phone;
  String address;

  @override
  Widget build(BuildContext context) {
    SchoolService schoolService = Provider.of<SchoolService>(context);

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
        body: ListView(
          children: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    content: Form(
                      key: _formKey,
                      child: Container(
                        height: MediaQuery.of(context).size.width - 80,
                        width: MediaQuery.of(context).size.width / 2,
                        child: ListView(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          // mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Register School',
                                style: GoogleFonts.roboto(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Container(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'School Name',
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'School name can not be empty';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      name = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Container(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Phone number',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Phone number can not be empty';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      phone = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Container(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Address',
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Address can not be empty';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      address = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  FlatButton(
                                    child: Text(
                                      'CANCEL',
                                      style: GoogleFonts.roboto(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .subhead
                                            .copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: RaisedButton(
                                      color: Theme.of(context).primaryColor,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.0),
                                      child: Text(
                                        "REGISTER",
                                        style: GoogleFonts.roboto(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .subhead
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                        ),
                                      ),
                                      onPressed: () async {
                                        if (_formKey.currentState.validate()) {
                                          _formKey.currentState.save();

                                          await schoolService.registerSchool(
                                              name, address, phone);
                                          Navigator.pop(context);
                                          showDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text(
                                                      'School is registered succesfully.'),
                                                  actions: <Widget>[
                                                    RaisedButton(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      child: Text(
                                                        'OK',
                                                        style:
                                                            GoogleFonts.roboto(
                                                          textStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .subhead
                                                                  .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ],
                                                );
                                              });
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
