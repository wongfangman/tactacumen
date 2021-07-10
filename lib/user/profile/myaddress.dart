import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';
import 'package:tactacumen/user/home/user.dart';
import 'package:tactacumen/user/profile/addaddress.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyAddress extends StatefulWidget {
  final User user;

  const MyAddress({Key key, this.user}) : super(key: key);

  @override
  _MyAddressState createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  String _titlecenter = "";
  List _addressBookList = [];

  @override
  void initState() {
    super.initState();
    _loadAddressBook();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('MY ADDRESS',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
          ],
        ),
        backgroundColor: Colors.blue[100],
        iconTheme: IconThemeData(color: Colors.black),
        toolbarHeight: 88,
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              if (_addressBookList.isEmpty)
                Flexible(
                    child: Center(
                  child: _titlecenter == ""
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Loading your address...",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black38)),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/myaddress.png",
                                height: 150, width: 150),
                            SizedBox(height: 15),
                            Container(
                              width: 250,
                              child: Text(
                                  "Looks like you haven't added an address yet.",
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black38)),
                            ),
                          ],
                        ),
                ))
              else
                Flexible(
                    child: OrientationBuilder(builder: (context, orientation) {
                  return GridView.count(
                      crossAxisCount: 1,
                      childAspectRatio: 2 / 1,
                      children: List.generate(_addressBookList.length, (index) {
                        return Padding(
                            padding: EdgeInsets.all(1),
                            child: Column(
                              children: [
                                SizedBox(height: 30),
                                Container(
                                    child: Card(
                                        child: Container(
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.blueAccent)),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 9,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Name: " +
                                                  _addressBookList[index]
                                                      ['fullname']),
                                              Text("Phone Number: " +
                                                  _addressBookList[index]
                                                      ['phoneno']),
                                              Text(
                                                "Detailed Address: " +
                                                    _addressBookList[index]
                                                        ['detailedaddress'],
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text("Postal Code: " +
                                                  _addressBookList[index]
                                                      ['postalcode']),
                                              Text("City: " +
                                                  _addressBookList[index]
                                                      ['city']),
                                              Text("State: " +
                                                  _addressBookList[index]
                                                      ['state']),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.delete),
                                              onPressed: () {
                                                _deleteAddressDialog(index);
                                              },
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ))),
                              ],
                            ));
                      }));
                })),
              IconButton(
                icon: Icon(Icons.add_circle, size: 30.0),
                onPressed: () {
                  _insertAddressDialog();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _loadAddressBook() {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/271221/tactacumen/php/load_address.php"),
        body: {"email": widget.user.email}).then((response) {
      if (response.body == "nodata") {
        _titlecenter = "Address is empty !";
        _addressBookList = [];

        setState(() {});
        return;
      } else {
        var jsondata = json.decode(response.body);
        _addressBookList = jsondata["address"];
      }
      setState(() {});
    });
  }

  void _deleteAddressDialog(int index) {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Delete this address?',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text("Yes"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _deleteAddress(index);
                    },
                  ),
                  TextButton(
                      child: Text("No"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ]),
        context: context);
  }

  Future<void> _deleteAddress(int index) async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: Text("Delete from cart"), title: Text("Progress..."));
    progressDialog.show();
    await Future.delayed(Duration(seconds: 1));
    http.post(
        Uri.parse(
            "https://hubbuddies.com/271221/tactacumen/php/delete_address.php"),
        body: {
          "email": widget.user.email,
          "fullname": _addressBookList[index]['fullname'],
          "phoneno": _addressBookList[index]['phoneno'],
          "detailedaddress": _addressBookList[index]['detailedaddress'],
          "postalcode": _addressBookList[index]['postalcode'],
          "city": _addressBookList[index]['city'],
          "state": _addressBookList[index]['state'],
        }).then((response) {
      if (response.body == "Success") {
        Fluttertoast.showToast(
            msg: "Success", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
        _loadAddressBook();
      } else {
        Fluttertoast.showToast(
            msg: "Failed", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
      }
      progressDialog.dismiss();
    });
  }

  void _insertAddressDialog() {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Add new address?',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text("Yes"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (content) =>
                                      AddAddress(user: widget.user)))
                          .then((_) => setState(() {
                                _loadAddressBook();
                              }));
                    },
                  ),
                  TextButton(
                      child: Text("No"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ]),
        context: context);
  }
}
