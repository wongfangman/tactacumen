import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'loginscreen.dart';
import 'package:email_validator/email_validator.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordControllera = new TextEditingController();
  TextEditingController _passwordControllerb = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        backgroundColor: Colors.blue[100],
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(70, 50, 70, 10),
                  child: Image.asset('assets/images/tactacumen.png', scale: 1)),
              SizedBox(height: 5),
              Card(
                margin: EdgeInsets.fromLTRB(30, 5, 30, 15),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                  child: Column(
                    children: [
                      Text('Registration',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24)),
                      TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              labelText: 'Email', icon: Icon(Icons.email))),
                      TextField(
                        controller: _passwordControllera,
                        decoration: InputDecoration(
                            labelText: 'Password', icon: Icon(Icons.lock)),
                        obscureText: true,
                      ),
                      TextField(
                        controller: _passwordControllerb,
                        decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            icon: Icon(Icons.lock)),
                        obscureText: true,
                      ),
                      SizedBox(height: 15),
                      MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          minWidth: 200,
                          height: 50,
                          child: Text('Register',
                              style: TextStyle(color: Colors.white)),
                          onPressed: _onRegister,
                          color: Colors.blue),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                child:
                    Text("Already Register?", style: TextStyle(fontSize: 16)),
                onTap: _alreadyRegister,
              ),
              SizedBox(height: 5),
            ],
          ),
        )),
      ),
    );
  }

  void _alreadyRegister() {
    Navigator.push(
        context, MaterialPageRoute(builder: (content) => LoginScreen()));
  }

  void _onRegister() {
    String _email = _emailController.text.toString();
    String _passworda = _passwordControllera.text.toString();
    String _passwordb = _passwordControllerb.text.toString();

    if (_email.isEmpty || _passworda.isEmpty || _passwordb.isEmpty) {
      Fluttertoast.showToast(
          msg: "Email/password is empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromRGBO(191, 30, 46, 50),
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } else if (EmailValidator.validate(_email) == false) {
      Fluttertoast.showToast(
        msg: "Invalid email address.",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    } else if (_passworda.length < 6) {
      Fluttertoast.showToast(
        msg: "Password should have at least 6 characters.",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    } else if (_passwordb.length < 6) {
      Fluttertoast.showToast(
        msg: "Password should have at least 6 characters.",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    } else if (_passworda != _passwordb) {
      Fluttertoast.showToast(
        msg: "Password and confirmation do not match.",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    }
    //checking the data integrity
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: Text("Register new user?"),
              content: Text("Are you sure?"),
              actions: [
                TextButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _registerUser(_email, _passworda);
                    }),
                TextButton(
                    child: Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }

  void _registerUser(String email, String password) {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/271221/tactacumen/php/register_user.php"),
        body: {"email": email, "password": password}).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg:
                "Registration Success. Please check your email for verification link.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromRGBO(191, 30, 46, 50),
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Registration Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromRGBO(191, 30, 46, 50),
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }
}
