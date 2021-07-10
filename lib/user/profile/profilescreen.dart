import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:tactacumen/user/profile/categories.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tactacumen/user/home/user.dart';
import 'package:http/http.dart' as http;
import 'package:tactacumen/user/profile/changepassword.dart';
import 'package:tactacumen/user/profile/myaddress.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  const ProfileScreen({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

enum Gender { Male, Female }

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String fullname = "Insert Your Name";
  String phonenumber = "Insert Your Phone Number";
  String gender = "Select Your Gender";
  String _birthday = "Select Your Birthday";
  DateTime selectedDate = DateTime.now();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(height: 1200),
                ShapeOfView(
                  shape: ArcShape(
                    direction: ArcDirection.Outside,
                    height: 45,
                    position: ArcPosition.Bottom,
                  ),
                  child: Container(
                    height: height * 0.32,
                    color: Colors.blue[100],
                  ),
                ),
                Positioned(
                  top: 150,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                        height: height * 0.2,
                        width: width * 0.3,
                        child: CircleAvatar(
                            backgroundColor: Colors.blue[100],
                            backgroundImage: widget.user.gender == 'Male'
                                ? AssetImage("assets/images/male.png")
                                : AssetImage("assets/images/female.png"))),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: height * 0.40),
                    Center(
                        child: Text(widget.user.fullname,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20))),
                    SizedBox(height: 10),
                  ],
                ),
                Positioned(
                  top: 350,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Categories(user: widget.user),
                  ),
                ),
                Positioned(
                  top: 480,
                  left: 0,
                  right: 0,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("Account",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: 520,
                    left: 0,
                    right: 0,
                    child: Card(
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.mail),
                              title: Text("Gmail"),
                              subtitle: Text(widget.user.email),
                            ),
                            ListTile(
                                leading: Icon(Icons.person),
                                title: Text("Full Name"),
                                subtitle: Text(widget.user.fullname == ""
                                    ? fullname
                                    : widget.user.fullname),
                                trailing: Icon(Icons.chevron_right),
                                onTap: () {
                                  _displayDialog1();
                                }),
                            ListTile(
                                leading: Icon(Icons.phone),
                                title: Text("Phone Number"),
                                subtitle: Text(widget.user.phoneno == ""
                                    ? phonenumber
                                    : widget.user.phoneno),
                                trailing: Icon(Icons.chevron_right),
                                onTap: () {
                                  _displayDialog2();
                                }),
                            ListTile(
                                leading: Icon(Icons.person_outline),
                                title: Text("Gender"),
                                subtitle: Text(widget.user.gender == ""
                                    ? gender
                                    : widget.user.gender),
                                trailing: Icon(Icons.chevron_right),
                                onTap: () {
                                  _asyncSimpleDialog(context);
                                }),
                            ListTile(
                              leading: Icon(Icons.cake),
                              title: Text("Birthday"),
                              subtitle: Text(widget.user.birthday == ""
                                  ? _birthday
                                  : widget.user.birthday),
                              trailing: Icon(Icons.chevron_right),
                              onTap: () {
                                setState(() {});
                                return buildMaterialDatePicker(context);
                              },
                            ),
                          ])),
                    )),
                Positioned(
                  top: 900,
                  left: 0,
                  right: 0,
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text("Address Book",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey)),
                    ),
                  ),
                ),
                Positioned(
                    top: 940,
                    left: 0,
                    right: 0,
                    child: Card(
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.location_on),
                              title: Text("My Address"),
                              trailing: Icon(Icons.chevron_right),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: MyAddress(user: widget.user),
                                  ),
                                );
                              },
                            ),
                          ])),
                    )),
                Positioned(
                  top: 1030,
                  left: 0,
                  right: 0,
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text("Security",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey)),
                    ),
                  ),
                ),
                Positioned(
                    top: 1070,
                    left: 0,
                    right: 0,
                    child: Card(
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.lock),
                              title: Text("Change Password"),
                              trailing: Icon(Icons.chevron_right),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: ChangePassword(user: widget.user),
                                  ),
                                );
                              },
                            ),
                          ])),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _displayDialog1() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Full Name'),
            content: TextField(
              controller: fullNameController,
              decoration: InputDecoration(
                  hintText: widget.user.fullname == ""
                      ? fullname
                      : widget.user.fullname),
            ),
            actions: <Widget>[
              // ignore: deprecated_member_use
              new FlatButton(
                child: new Text('SAVE'),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    widget.user.fullname = fullNameController.text.toString();
                  });
                  _updateinfo();
                },
              )
            ],
          );
        });
  }

  _displayDialog2() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Phone Number'),
            content: TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                  hintText: widget.user.phoneno == ""
                      ? phonenumber
                      : widget.user.phoneno),
            ),
            actions: <Widget>[
              // ignore: deprecated_member_use
              new FlatButton(
                child: new Text('SAVE'),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    widget.user.phoneno = phoneNumberController.text.toString();
                  });
                  _updateinfo();
                },
              )
            ],
          );
        });
  }

  Future<Gender> _asyncSimpleDialog(BuildContext context) async {
    return await showDialog<Gender>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select Gender'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  setState(() {
                    widget.user.gender = "Male";
                  });
                  _updateinfo();
                  Navigator.pop(context, Gender.Male);
                },
                child: const Text('Male'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  setState(() {
                    widget.user.gender = "Female";
                  });
                  _updateinfo();
                  Navigator.pop(context, Gender.Female);
                },
                child: const Text('Female'),
              ),
            ],
          );
        });
  }

  buildMaterialDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: new DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        widget.user.birthday = dateFormat.format(selectedDate);
      });
    _updateinfo();
  }

  void _updateinfo() {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/271221/tactacumen/php/update_info.php"),
        body: {
          "email": widget.user.email,
          "fullname": widget.user.fullname,
          "phoneno": widget.user.phoneno,
          "gender": widget.user.gender,
          "birthday": widget.user.birthday
        }).then((response) {
      if (response.body == "Success") {
        Fluttertoast.showToast(
            msg: "Success.", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
        setState(() {});
        return;
      } else {
        Fluttertoast.showToast(
            msg: "Please Try Again.",
            toastLength: Toast.LENGTH_SHORT,
            fontSize: 16.0);
        setState(() {});
      }
    });
  }
}
