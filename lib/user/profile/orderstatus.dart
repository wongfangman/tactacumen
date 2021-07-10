import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tactacumen/user/home/user.dart';

class OrderStatus extends StatefulWidget {
  final String title;
  final User user;
  final String status;

  const OrderStatus({Key key, this.user, this.status, this.title})
      : super(key: key);
  @override
  _OrderStatusState createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  String _titlecenter = "Loading your order...";
  List _orderList = [];

  @override
  void initState() {
    super.initState();
    _loadMyOrder();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(widget.title,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold))
            ],
          ),
          backgroundColor: Colors.blue[100],
          iconTheme: IconThemeData(color: Colors.black),
          toolbarHeight: 88,
        ),
        body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              children: [
                if (_orderList.isEmpty)
                  Flexible(
                      child: Center(
                    child: _titlecenter == "Loading your order..."
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
                              Image.asset("assets/images/orderstatus.png",
                                  height: 300, width: 600),
                              SizedBox(height: 15),
                              Container(
                                width: 250,
                                child: Column(
                                  children: [
                                    Text("Order Now",
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.black)),
                                    Text("We hope to serve you.",
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black38)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ))
                else
                  Flexible(child:
                      OrientationBuilder(builder: (context, orientation) {
                    return GridView.count(
                        crossAxisCount: 1,
                        childAspectRatio: 3 / 1,
                        children: List.generate(_orderList.length, (index) {
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
                                      height:
                                          orientation == Orientation.portrait
                                              ? 100
                                              : 150,
                                      width: orientation == Orientation.portrait
                                          ? 100
                                          : 150,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "https://hubbuddies.com/271221/tactacumen/images/product_pictures/${_orderList[index]['prid']}.jpg",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                      height: 100,
                                      child:
                                          VerticalDivider(color: Colors.grey)),
                                  Expanded(
                                    flex: 6,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "Order ID: " +
                                                  _orderList[index]['orderid'],
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight:
                                                      FontWeight.normal)),
                                          Text(_orderList[index]['prname'],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                          Row(
                                            children: [
                                              Text(
                                                  "x" +
                                                      _orderList[index]
                                                          ['orderqty'],
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(width: 10),
                                              Text(
                                                  "RM " +
                                                      _orderList[index]
                                                          ['prprice'],
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.normal)),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "RM " +
                                                (int.parse(_orderList[index]
                                                            ['orderqty']) *
                                                        double.parse(
                                                            _orderList[index]
                                                                ['prprice']))
                                                    .toStringAsFixed(2),
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ))));
                        }));
                  })),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _loadMyOrder() {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/271221/tactacumen/php/load_status.php"),
        body: {
          "email": widget.user.email,
          "status": widget.status
        }).then((response) {
      if (response.body == "nodata") {
        _titlecenter = "Order is empty !";
        _orderList = [];
        setState(() {});
        return;
      } else {
        var jsondata = json.decode(response.body);
        _orderList = jsondata["order"];
        _titlecenter = "";
      }
      setState(() {});
    });
  }
}
