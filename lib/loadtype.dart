import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tactacumen/sizeconfig.dart';

class LoadType extends StatefulWidget {
  final String prtype;

  const LoadType({Key key, this.prtype}) : super(key: key);
  @override
  _LoadTypeScreenState createState() => _LoadTypeScreenState();
}

class _LoadTypeScreenState extends State<LoadType> {
  double screenHeight, screenWidth;
  List _prlist;
  String _titlecenter = "Loading...";

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.prtype,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)))
          ],
        ),
        backgroundColor: Colors.blue[100],
        iconTheme: IconThemeData(color: Colors.black),
        toolbarHeight: 88,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            onPressed: () => {},
            icon: Icon(Icons.notifications),
          ),
        ],
      ),
      body: Center(
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
                                Container(
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
                                        Container(
                                          width:
                                              getProportionateScreenWidth(28),
                                          height:
                                              getProportionateScreenWidth(28),
                                          decoration: BoxDecoration(
                                            color: Color(0xFF979797)
                                                .withOpacity(0.1),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(Icons.favorite,
                                              color: Colors.grey),
                                        ),
                                      ]),
                                )
                              ]))));
                    }),
                  ),
                )),
        ]),
      ),
    );
  }

  void _loadProducts(String prtype) {
    http.post(
        Uri.parse("https://hubbuddies.com/271221/tactacumen/php/load_type.php"),
        body: {"prtype": widget.prtype}).then((response) {
      if (response.body == "nodata") {
        _titlecenter = "No data.";
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
