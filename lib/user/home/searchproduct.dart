import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tactacumen/sizeconfig.dart';
import 'package:tactacumen/user/home/user.dart';
import 'package:tactacumen/user/product/details.dart';
import 'package:tactacumen/user/product/detailsscreen.dart';

class SearchProduct extends StatefulWidget {
  final User user;
  final String prname;
  const SearchProduct({Key key, this.prname, this.user}) : super(key: key);
  @override
  _SearchProductAppState createState() => _SearchProductAppState();
}

class _SearchProductAppState extends State<SearchProduct> {
  double screenHeight, screenWidth;
  List _prlist;
  String _titlecenter = "Search...";
  Details details;

  @override
  void initState() {
    super.initState();
    _loadProducts(widget.prname);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Column(children: [
        _prlist == null
            ? Flexible(
                child: Center(child: Text(_titlecenter)),
              )
            : Flexible(
                child: Center(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: (screenWidth / screenHeight) / 0.7,
                  children: List.generate(_prlist.length, (index) {
                    return Padding(
                        padding: EdgeInsets.fromLTRB(5, 15, 5, 5),
                        child: Card(
                            elevation: 10,
                            child: SingleChildScrollView(
                                child: Column(children: [
                              GestureDetector(
                                onTap: () => {
                                  details = Details(
                                    prid: _prlist[index]['prid'],
                                    primage: CachedNetworkImage(
                                      imageUrl:
                                          "https://hubbuddies.com/271221/tactacumen/images/product_pictures/${_prlist[index]['prid']}.jpg",
                                    ),
                                    prname: _prlist[index]['prname'],
                                    prtype: _prlist[index]['prtype'],
                                    prprice: _prlist[index]['prprice'],
                                    prqty: _prlist[index]['prqty'],
                                    prdescription: _prlist[index]
                                        ['prdescription'],
                                    prlength: _prlist[index]['prlength'],
                                    prwidth: _prlist[index]['prwidth'],
                                    prheight: _prlist[index]['prheight'],
                                  ),
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (content) => DetailsScreen(
                                              details: details,
                                              user: widget.user)))
                                },
                                child: Container(
                                  height: screenHeight / 4.5,
                                  width: screenWidth / 1.2,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "https://hubbuddies.com/271221/tactacumen/images/product_pictures/${_prlist[index]['prid']}.jpg",
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        new Transform.scale(
                                            scale: 0.5,
                                            child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        new Icon(
                                      Icons.broken_image,
                                      size: screenWidth / 3,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Column(
                                  children: [
                                    Text(
                                      _prlist[index]['prname'],
                                      style: TextStyle(color: Colors.black),
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("RM " + _prlist[index]['prprice'],
                                          style: TextStyle(
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      18),
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFFFF7643))),
                                    ]),
                              )
                            ]))));
                  }),
                ),
              )),
      ]),
    );
  }

  void _loadProducts(String prname) {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/271221/tactacumen/php/load_products.php"),
        body: {"prname": widget.prname}).then((response) {
      if (response.body == "nodata") {
        _titlecenter = "Sorry, no product available!";
        setState(() {});
        return;
      } else {
        var jsondata = json.decode(response.body);
        _prlist = jsondata["products"];
        setState(() {});
      }
    });
  }
}
