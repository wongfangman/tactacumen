import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    Key key,
  }) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool isObscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(left: 15, top: 20, right: 15),
          child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ListView(
                children: [
                  Center(
                      child: Stack(
                    children: [
                      Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                              border: Border.all(width: 4, color: Colors.white),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/images/profile.png"),
                              ))),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 4,
                                  color: Colors.white,
                                ),
                                color: Colors.blue[100],
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Colors.black,
                              ))),
                    ],
                  )),
                  SizedBox(height: 30),
                  buildTextField("Full Name", "Wong Fang Man", false),
                  buildTextField("Phone Number", "016-4497347", false),
                  buildTextField("Email", "fangman0218@gmail.com", false),
                  buildTextField("Password", "******", true),
                  buildTextField("Address", "Penang, Malaysia", false),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 130,
                        height: 40,
                        child: OutlinedButton(
                            onPressed: () {},
                            child: Text("CANCEL",
                                style: TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 2,
                                    color: Colors.black)),
                            style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                      ),
                      SizedBox(
                        width: 130,
                        height: 40,
                        child: ElevatedButton(
                            onPressed: () {},
                            child: Text("SAVE",
                                style: TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 2,
                                    color: Colors.black)),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blue[100],
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                ],
              ))),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: TextField(
            obscureText: isPasswordTextField ? isObscurePassword : false,
            decoration: InputDecoration(
                suffixIcon: isPasswordTextField
                    ? IconButton(
                        icon: Icon(Icons.remove_red_eye, color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            isObscurePassword = !isObscurePassword;
                          });
                        })
                    : null,
                contentPadding: EdgeInsets.only(bottom: 5),
                labelText: labelText,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: placeholder,
                hintStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ))));
  }
}
