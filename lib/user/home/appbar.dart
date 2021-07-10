import 'package:flutter/material.dart';
import 'package:tactacumen/user/home/homecreen.dart';
import 'package:tactacumen/user/home/user.dart';

AppBar appBar(BuildContext context, User user) {
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/tactacumen.png',
          fit: BoxFit.contain,
          height: 40,
        ),
        Text(' TACT ACUMEN',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
      ],
    ),
    backgroundColor: Colors.blue[100],
    iconTheme: IconThemeData(color: Colors.black),
    toolbarHeight: 88,
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          showSearch(context: context, delegate: DataSearch(user: user));
        },
      ),
    ],
  );
}
