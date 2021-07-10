import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';
import 'package:tactacumen/user/product/details.dart';
import 'package:tactacumen/user/home/user.dart';
import 'package:http/http.dart' as http;

class DetailsScreen extends StatefulWidget {
  final User user;
  final Details details;

  const DetailsScreen({Key key, this.details, this.user}) : super(key: key);
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue[100],
        child: ListView(children: [
          Stack(
            children: [
              Container(
                height: 350.0,
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 60.0, bottom: 20.0),
                  child: Hero(tag: "", child: widget.details.primage),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        iconSize: 30.0,
                        onPressed: () => Navigator.pop(context)),
                  ],
                ),
              ),
            ],
          ),
          Padding(
              padding: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
              child: Text(widget.details.prname,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 30.0,
                    color: Colors.black,
                  ))),
          SizedBox(height: 10.0),
          Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(widget.details.prtype,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                  ))),
          SizedBox(height: 25.0),
          Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text('Details', style: TextStyle(fontSize: 16.0))),
          SizedBox(height: 5.0),
          Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(widget.details.prdescription.toString(),
                  style: TextStyle(fontSize: 16.0, color: Colors.black54))),
          SizedBox(height: 40.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  height: 60.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 2),
                          blurRadius: 20.0,
                        )
                      ]),
                  child: Center(
                    child:
                        Text("L: " + widget.details.prlength.toString() + " cm",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            )),
                  )),
              Container(
                  height: 60.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 2),
                          blurRadius: 20.0,
                        )
                      ]),
                  child: Center(
                    child:
                        Text("W: " + widget.details.prwidth.toString() + " cm",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            )),
                  )),
              Container(
                  height: 60.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 2),
                          blurRadius: 20.0,
                        )
                      ]),
                  child: Center(
                    child:
                        Text("H: " + widget.details.prheight.toString() + " cm",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            )),
                  )),
            ],
          ),
          SizedBox(height: 50.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  height: 60.0,
                  width: 350.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.blue,
                  ),
                  child: GestureDetector(
                    onTap: () => {
                      _addtocart(),
                    },
                    child: Center(
                      child: Text('Add to Cart',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20.0,
                          )),
                    ),
                  )),
            ],
          ),
          SizedBox(height: 30.0),
        ]),
      ),
    );
  }

  _addtocart() async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: Text("Add to cart"), title: Text("Progress..."));
    progressDialog.show();
    await Future.delayed(Duration(seconds: 1));
    http.post(
        Uri.parse(
            "https://hubbuddies.com/271221/tactacumen/php/insert_cart.php"),
        body: {
          "email": widget.user.email,
          "prid": widget.details.prid
        }).then((response) {
      if (response.body == "Failed") {
        Fluttertoast.showToast(
            msg: "Failed", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Success", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
      }
    });
    progressDialog.dismiss();
  }
}
