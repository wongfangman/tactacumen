import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tactacumen/user/home/user.dart';

class FeedBack extends StatefulWidget {
  final User user;
  const FeedBack({Key key, this.user}) : super(key: key);
  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  List<bool> isTypeSelected = [false, false, false, false, false];
  TextEditingController feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('FEEDBACK',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
          ],
        ),
        backgroundColor: Colors.blue[100],
        iconTheme: IconThemeData(color: Colors.black),
        toolbarHeight: 88,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Please select the type of the feedback.",
                style: TextStyle(
                  color: Color(0xFFC5C5C5),
                ),
              ),
              SizedBox(height: 25.0),
              GestureDetector(
                child: buildCheckItem(
                    title: "Login trouble", isSelected: isTypeSelected[0]),
                onTap: () {
                  setState(() {
                    isTypeSelected[0] = !isTypeSelected[0];
                    isTypeSelected[1] = false;
                    isTypeSelected[2] = false;
                    isTypeSelected[3] = false;
                    isTypeSelected[4] = false;
                  });
                },
              ),
              GestureDetector(
                child: buildCheckItem(
                    title: "Phone number related",
                    isSelected: isTypeSelected[1]),
                onTap: () {
                  setState(() {
                    isTypeSelected[1] = !isTypeSelected[1];
                    isTypeSelected[0] = false;
                    isTypeSelected[2] = false;
                    isTypeSelected[3] = false;
                    isTypeSelected[4] = false;
                  });
                },
              ),
              GestureDetector(
                child: buildCheckItem(
                    title: "Personal profile", isSelected: isTypeSelected[2]),
                onTap: () {
                  setState(() {
                    isTypeSelected[2] = !isTypeSelected[2];
                    isTypeSelected[0] = false;
                    isTypeSelected[1] = false;
                    isTypeSelected[3] = false;
                    isTypeSelected[4] = false;
                  });
                },
              ),
              GestureDetector(
                child: buildCheckItem(
                    title: "Other issues", isSelected: isTypeSelected[3]),
                onTap: () {
                  setState(() {
                    isTypeSelected[3] = !isTypeSelected[3];
                    isTypeSelected[0] = false;
                    isTypeSelected[1] = false;
                    isTypeSelected[2] = false;
                    isTypeSelected[4] = false;
                  });
                },
              ),
              GestureDetector(
                child: buildCheckItem(
                    title: "Suggestions", isSelected: isTypeSelected[4]),
                onTap: () {
                  setState(() {
                    isTypeSelected[4] = !isTypeSelected[4];
                    isTypeSelected[0] = false;
                    isTypeSelected[1] = false;
                    isTypeSelected[2] = false;
                    isTypeSelected[3] = false;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 150,
                child: Stack(
                  children: [
                    TextField(
                      controller: feedbackController,
                      maxLines: 10,
                      decoration: InputDecoration(
                        hintText: "Please briefly describe the issue.",
                        hintStyle: TextStyle(
                          fontSize: 13.0,
                          color: Color(0xFFC5C5C5),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFE5E5E5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      minWidth: 200,
                      height: 50,
                      child:
                          Text('SUBMIT', style: TextStyle(color: Colors.white)),
                      onPressed: _checkFeedback,
                      color: Colors.blue),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCheckItem({String title, bool isSelected}) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        children: [
          Icon(
            isSelected ? Icons.check_circle : Icons.circle,
            color: isSelected ? Colors.blue : Colors.grey,
          ),
          SizedBox(width: 10.0),
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.blue : Colors.grey),
          ),
        ],
      ),
    );
  }

  void _checkFeedback() {
    FocusScope.of(context).unfocus();
    String fbtype;
    String fbmessage = feedbackController.text.toString();
    String login = isTypeSelected[0].toString();
    String phone = isTypeSelected[1].toString();
    String profile = isTypeSelected[2].toString();
    String other = isTypeSelected[3].toString();
    String suggestions = isTypeSelected[4].toString();

    if ((login == "false" &&
        phone == "false" &&
        profile == "false" &&
        other == "false" &&
        suggestions == "false")) {
      Fluttertoast.showToast(
          msg: "Selection is empty",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.black,
          fontSize: 16.0);
      return;
    } else if (feedbackController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Text field is empty",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.black,
          fontSize: 16.0);
      return;
    }
    if (login == "true") {
      fbtype = "Login Trouble";
    } else if (phone == "true") {
      fbtype = "Phone Number Related";
    } else if (profile == "true") {
      fbtype = "Personal Profile";
    } else if (other == "true") {
      fbtype = "Other Issues";
    } else if (suggestions == "true") {
      fbtype = "Suggestions";
    }
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Send feedback?',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text("Yes"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _sendFeedback(fbtype, fbmessage);
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

  void _sendFeedback(String fbtype, String fbmessage) {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/271221/tactacumen/php/insert_feedback.php"),
        body: {
          "email": widget.user.email,
          "fbtype": fbtype,
          "fbmessage": fbmessage,
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
