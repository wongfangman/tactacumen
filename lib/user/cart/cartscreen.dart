import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';
import 'package:tactacumen/user/home/homecreen.dart';
import 'package:tactacumen/user/drawer/mydrawer.dart';
import 'package:tactacumen/user/home/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tactacumen/user/payment/checkoutscreen.dart';

class CartScreen extends StatefulWidget {
  final User user;
  const CartScreen({Key key, this.user}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String _titlecenter = "Loading your cart...";
  List _cartList = [];
  double _totalprice = 0.0;

  @override
  void initState() {
    super.initState();
    _loadMyCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: myDrawer(context, widget.user),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('YOUR CART',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
          ],
        ),
        backgroundColor: Colors.blue[100],
        iconTheme: IconThemeData(color: Colors.black),
        toolbarHeight: 88,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context, delegate: DataSearch(user: widget.user));
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            if (_cartList.isEmpty)
              Flexible(
                  child: Center(
                child: _titlecenter == "Loading your cart..."
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(_titlecenter,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black38)),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/emptycart.png",
                              height: 150, width: 150),
                          SizedBox(height: 15),
                          Container(
                            width: 250,
                            child: Text(
                                "Looks like you haven't added anything to your cart yet.",
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
                    childAspectRatio: 3 / 1,
                    children: List.generate(_cartList.length, (index) {
                      return Padding(
                          padding: EdgeInsets.all(1),
                          child: Container(
                              child: Card(
                                  child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  height: orientation == Orientation.portrait
                                      ? 100
                                      : 150,
                                  width: orientation == Orientation.portrait
                                      ? 100
                                      : 150,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "https://hubbuddies.com/271221/tactacumen/images/product_pictures/${_cartList[index]['prid']}.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                  height: 100,
                                  child: VerticalDivider(color: Colors.grey)),
                              Expanded(
                                flex: 6,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(_cartList[index]['prname'],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.remove),
                                            onPressed: () {
                                              _modQty(index, "removecart");
                                            },
                                          ),
                                          Text(_cartList[index]['cartqty']),
                                          IconButton(
                                            icon: Icon(Icons.add),
                                            onPressed: () {
                                              _modQty(index, "addcart");
                                            },
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "RM " +
                                            (int.parse(_cartList[index]
                                                        ['cartqty']) *
                                                    double.parse(
                                                        _cartList[index]
                                                            ['prprice']))
                                                .toStringAsFixed(2),
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      )
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
                                        _deleteCartDialog(index);
                                      },
                                    )
                                  ],
                                ),
                              )
                            ],
                          ))));
                    }));
              })),
            Container(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: 5),
                    Divider(
                      color: Colors.red,
                      height: 1,
                      thickness: 10.0,
                    ),
                    Text(
                      "TOTAL RM " + _totalprice.toStringAsFixed(2),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _payDialog();
                      },
                      child: Text("CHECKOUT"),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  _loadMyCart() {
    http.post(
        Uri.parse("https://hubbuddies.com/271221/tactacumen/php/load_cart.php"),
        body: {"email": widget.user.email}).then((response) {
      if (response.body == "nodata") {
        _titlecenter = "Cart is empty !";
        _cartList = [];
        _totalprice = 0.0;
        setState(() {});
        return;
      } else {
        var jsondata = json.decode(response.body);

        _cartList = jsondata["cart"];

        _titlecenter = "";
        _totalprice = 0.0;
        for (int i = 0; i < _cartList.length; i++) {
          _totalprice = _totalprice +
              double.parse(_cartList[i]['prprice']) *
                  int.parse(_cartList[i]['cartqty']);
        }
      }
      setState(() {});
    });
  }

  Future<void> _modQty(int index, String s) async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: Text("Update cart"), title: Text("Progress..."));
    progressDialog.show();
    await Future.delayed(Duration(seconds: 1));
    http.post(
        Uri.parse(
            "https://hubbuddies.com/271221/tactacumen/php/update_cart.php"),
        body: {
          "email": widget.user.email,
          "op": s,
          "prid": _cartList[index]['prid'],
          "cartqty": _cartList[index]['cartqty']
        }).then((response) {
      if (response.body == "Success") {
        Fluttertoast.showToast(
            msg: "Success", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
        _loadMyCart();
      } else {
        Fluttertoast.showToast(
            msg: "Failed", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
      }
      progressDialog.dismiss();
    });
  }

  Future<void> _deleteCart(int index) async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: Text("Delete from cart"), title: Text("Progress..."));
    progressDialog.show();
    await Future.delayed(Duration(seconds: 1));
    http.post(
        Uri.parse(
            "https://hubbuddies.com/271221/tactacumen/php/delete_cart.php"),
        body: {
          "email": widget.user.email,
          "prid": _cartList[index]['prid']
        }).then((response) {
      if (response.body == "Success") {
        Fluttertoast.showToast(
            msg: "Success", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
        _loadMyCart();
      } else {
        Fluttertoast.showToast(
            msg: "Failed", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
      }
      progressDialog.dismiss();
    });
  }

  void _deleteCartDialog(int index) {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Delete from your cart?',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text("Yes"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _deleteCart(index);
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

  void _payDialog() {
    if (_totalprice == 0.0) {
      Fluttertoast.showToast(
          msg: "Amount not payable",
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 16.0);
      return;
    } else {
      showDialog(
          builder: (context) => new AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  title: new Text(
                    'Proceed with checkout?',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text("Yes"),
                      onPressed: () async {
                        Navigator.of(context).pop();
                        await Navigator.of(context)
                            .push(
                              MaterialPageRoute(
                                builder: (context) => CheckOutScreen(
                                    user: widget.user, total: _totalprice),
                              ),
                            )
                            .then((value) => setState(() {
                                  _loadMyCart();
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
}
