import 'package:flutter/material.dart';
import 'user.dart';

class MainScreen extends StatefulWidget {
  final User user;

  const MainScreen({Key key, this.user}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      drawer: Drawer(
        child: ListView(children: [
          UserAccountsDrawerHeader(
            accountEmail: Text(widget.user.email),
            currentAccountPicture: CircleAvatar(
              backgroundColor:
                  Theme.of(context).platform == TargetPlatform.android
                      ? Colors.white
                      : Colors.red,
              child: Text(
                  widget.user.email.toString().substring(0, 1).toUpperCase(),
                  style: TextStyle(fontSize: 40)),
              backgroundImage: AssetImage("assets/images/profilea.png"),
            ),
            accountName: null,
          ),
          ListTile(
              title: Text("Piston Compressor"),
              onTap: () {
                Navigator.pop(context);
              }),
          ListTile(
              title: Text("Screw Compressor"),
              onTap: () {
                Navigator.pop(context);
              }),
          ListTile(
              title: Text("Air Dryer"),
              onTap: () {
                Navigator.pop(context);
              }),
          ListTile(
              title: Text("Messaging"),
              onTap: () {
                Navigator.pop(context);
              }),
          ListTile(
              title: Text("Profile"),
              onTap: () {
                Navigator.pop(context);
              }),
        ]),
      ),
      body: Center(
        child: Column(children: [
          Text("User " + widget.user.email),
          Text("Date Reg " + widget.user.datareg),
          Text("Status " + widget.user.status),
          Text("Credit " + widget.user.credit),
        ]),
      ),
    );
  }
}
