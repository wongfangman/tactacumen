import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tactacumen/user/home/user.dart';

class ChangePassword extends StatefulWidget {
  final User user;

  const ChangePassword({Key key, this.user}) : super(key: key);
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('CHANGE PASSWORD',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
          ],
        ),
        backgroundColor: Colors.blue[100],
        iconTheme: IconThemeData(color: Colors.black),
        toolbarHeight: 88,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Center(
            child: Column(
              children: [
                Flexible(
                  child: ListView(
                    children: [
                      changepassword("Current Password", "Current Password",
                          "currentpassword"),
                      changepassword(
                          "New Password", "New Password", "newpassword"),
                      changepassword("Confirm Password", "Confirm Password",
                          "confirmpassword"),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          minWidth: 200,
                          height: 50,
                          child: Text('Save',
                              style: TextStyle(color: Colors.white)),
                          onPressed: _savePass,
                          color: Colors.blue),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: missing_return
  Widget changepassword(
      String labelText, String placeholder, String textField) {
    if (textField == "currentpassword") {
      return Padding(
        padding: const EdgeInsets.only(bottom: 35.0),
        child: TextField(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 6),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: labelText,
              labelStyle: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              hintText: placeholder,
              hintStyle: TextStyle(
                height: 3,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              )),
          controller: currentPasswordController,
        ),
      );
    } else if (textField == "newpassword") {
      return Padding(
        padding: const EdgeInsets.only(bottom: 35.0),
        child: TextField(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 6),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: labelText,
              labelStyle: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              hintText: placeholder,
              hintStyle: TextStyle(
                height: 3,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              )),
          controller: newPasswordController,
        ),
      );
    } else if (textField == "confirmpassword") {
      return Padding(
        padding: const EdgeInsets.only(bottom: 35.0),
        child: TextField(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 6),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: labelText,
              labelStyle: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              hintText: placeholder,
              hintStyle: TextStyle(
                height: 3,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              )),
          controller: confirmPasswordController,
        ),
      );
    }
  }

  void _savePass() {
    if (currentPasswordController.text.isEmpty ||
        newPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Any text field is empty",
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 16.0);
      return;
    } else if (newPasswordController.text != confirmPasswordController.text) {
      Fluttertoast.showToast(
          msg: "New password and confirm password is not same.",
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 16.0);
      return;
    } else if (newPasswordController.text.toString().contains(RegExp(r'[ ]'))) {
      Fluttertoast.showToast(
          msg: "Please dont not use space in password.",
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 16.0);
      return;
    }

    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Reset new password?',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text("Yes"),
                    onPressed: () {
                      _updatePassword();
                      Navigator.of(context).pop();
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

  void _updatePassword() {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/271221/tactacumen/php/update_password.php"),
        body: {
          "email": widget.user.email,
          "currentpassword": currentPasswordController.text.toString(),
          "newpassword": newPasswordController.text.toString(),
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
