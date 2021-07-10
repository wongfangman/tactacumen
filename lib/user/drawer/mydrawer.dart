import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tactacumen/loginscreen.dart';
import 'package:tactacumen/user/drawer/contactus.dart';
import 'package:tactacumen/user/drawer/ecatalogue.dart';
import 'package:tactacumen/user/drawer/feedback.dart';
import 'package:tactacumen/user/drawer/privacypolicy.dart';
import 'package:tactacumen/user/home/homecreen.dart';
import 'package:tactacumen/user/home/user.dart';

Drawer myDrawer(BuildContext context, User user) {
  return Drawer(
    child: ListView(children: [
      Container(
        padding: EdgeInsets.symmetric(vertical: 0.0),
        height: 100,
        child: DrawerHeader(
          child: Center(
            child: ListTile(
              subtitle: Text(
                user.email,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              title: Text(
                user.fullname,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              leading: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).platform == TargetPlatform.android
                          ? Colors.white
                          : Colors.blue[100],
                  backgroundImage: user.gender == 'Male'
                      ? AssetImage("assets/images/male.png")
                      : AssetImage("assets/images/female.png")),
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.blue[100],
          ),
        ),
      ),
      ListTile(
        leading: Icon(
          Feather.home,
          color: Colors.black,
        ),
        title: Text(
          'Home',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: HomeScreen(user: user),
            ),
          );
        },
      ),
      ListTile(
        leading: Icon(Feather.file, color: Colors.black),
        title: Text('E-Catalogue',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black)),
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: ECatalogue(),
            ),
          );
        },
      ),
      ListTile(
        leading: Icon(Feather.message_circle, color: Colors.black),
        title: Text('Feedback',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black)),
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: FeedBack(user: user),
            ),
          );
        },
      ),
      ListTile(
        leading: Icon(Feather.phone, color: Colors.black),
        title: Text('Contact Us',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black)),
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: ContactUs(),
            ),
          );
        },
      ),
      ListTile(
        leading: Icon(Feather.shield, color: Colors.black),
        title: Text('Privacy Policy',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black)),
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: PrivacyPolicy(),
            ),
          );
        },
      ),
      ListTile(
        leading: Icon(Feather.x_circle, color: Colors.black),
        title: Text('Log Out',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black)),
        onTap: () {
          _logout(context);
        },
      ),
    ]),
  );
}

Future<bool> _logout(context) {
  return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: new Text(
            'Do you want to logout?',
            style: TextStyle(),
          ),
          content: new Text(
            'Are your sure?',
            style: TextStyle(),
          ),
          actions: <Widget>[
            MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (content) => LoginScreen()));
                },
                child: Text(
                  "Yes",
                  style: TextStyle(),
                )),
            MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "No",
                  style: TextStyle(),
                )),
          ],
        ),
      ) ??
      false;
}
