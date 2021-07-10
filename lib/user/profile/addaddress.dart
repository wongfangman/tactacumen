import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tactacumen/user/home/user.dart';
import 'package:http/http.dart' as http;

class AddAddress extends StatefulWidget {
  final User user;

  const AddAddress({Key key, this.user}) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

enum StateMalaysia {
  Johor,
  Kedah,
  Kelantan,
  KualaLumpur,
  Labuan,
  Melaka,
  NegeriSembilan,
  Pahang,
  Penang,
  Perak,
  Perlis,
  Putrajaya,
  Sabah,
  Sarawak,
  Selangor,
  Terengganu
}

class _AddAddressState extends State<AddAddress> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController detailAddressController = TextEditingController();
  String fullname = "Set Full Name";
  String phoneNumber = "Set Phone Number";
  String state = "Set State";
  String city = "Set City";
  String postalcode = "Set Postal Code";
  String detailedaddress = "Set Detailed Address";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('ADD ADDRESS',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold))
            ],
          ),
          backgroundColor: Colors.blue[100],
          iconTheme: IconThemeData(color: Colors.black),
          toolbarHeight: 88,
        ),
        body: Column(
          children: [
            Flexible(
              child: Card(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(children: <Widget>[
                      ListTile(
                          title: Text("Full Name"),
                          subtitle: Text(fullname),
                          trailing: Icon(Icons.chevron_right),
                          onTap: () {
                            _displayDialog1();
                          }),
                      ListTile(
                          title: Text("Phone Number"),
                          subtitle: Text(phoneNumber),
                          trailing: Icon(Icons.chevron_right),
                          onTap: () {
                            _displayDialog2();
                          }),
                      ListTile(
                          title: Text("State"),
                          subtitle: Text(state),
                          trailing: Icon(Icons.chevron_right),
                          onTap: () {
                            _asyncSimpleDialog(context);
                          }),
                      ListTile(
                          title: Text("City"),
                          subtitle: Text(city),
                          trailing: Icon(Icons.chevron_right),
                          onTap: () {
                            _displayDialog3();
                          }),
                      ListTile(
                          title: Text("Postal Code"),
                          subtitle: Text(postalcode),
                          trailing: Icon(Icons.chevron_right),
                          onTap: () {
                            _displayDialog4();
                          }),
                      ListTile(
                          title: Text("Detailed Address"),
                          subtitle: Text(detailedaddress),
                          trailing: Icon(Icons.chevron_right),
                          onTap: () {
                            _displayDialog5();
                          }),
                    ])),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 132, 10, 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      minWidth: 200,
                      height: 50,
                      child:
                          Text('Submit', style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        _insertAddress();
                      },
                      color: Colors.blue),
                ],
              ),
            )
          ],
        ));
  }

  _displayDialog1() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Full Name'),
            content: TextField(
              controller: fullNameController,
              decoration: InputDecoration(hintText: "Full Name"),
            ),
            actions: <Widget>[
              // ignore: deprecated_member_use
              new FlatButton(
                child: new Text('SAVE'),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    fullname = fullNameController.text.toString();
                  });
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
              decoration: InputDecoration(hintText: "Phone Number"),
            ),
            actions: <Widget>[
              // ignore: deprecated_member_use
              new FlatButton(
                child: new Text('SAVE'),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    phoneNumber = phoneNumberController.text.toString();
                  });
                },
              )
            ],
          );
        });
  }

  Future<StateMalaysia> _asyncSimpleDialog(BuildContext context) async {
    return await showDialog<StateMalaysia>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select State'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  setState(() {
                    state = "Johor";
                  });
                  Navigator.pop(context, StateMalaysia.Johor);
                },
                child: const Text('Johor'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  setState(() {
                    state = "Kedah";
                  });
                  Navigator.pop(context, StateMalaysia.Kedah);
                },
                child: const Text('Kedah'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  setState(() {
                    state = "Kelantan";
                  });
                  Navigator.pop(context, StateMalaysia.Kelantan);
                },
                child: const Text('Kelantan'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  setState(() {
                    state = "KualaLumpur";
                  });
                  Navigator.pop(context, StateMalaysia.KualaLumpur);
                },
                child: const Text('Kuala Lumpur'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  setState(() {
                    state = "Labuan";
                  });
                  Navigator.pop(context, StateMalaysia.Labuan);
                },
                child: const Text('Labuan'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  setState(() {
                    state = "Melaka";
                  });
                  Navigator.pop(context, StateMalaysia.Melaka);
                },
                child: const Text('Melaka'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  setState(() {
                    state = "NegeriSembilan";
                  });
                  Navigator.pop(context, StateMalaysia.NegeriSembilan);
                },
                child: const Text('Negeri Sembilan'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  setState(() {
                    state = "Pahang";
                  });
                  Navigator.pop(context, StateMalaysia.Pahang);
                },
                child: const Text('Pahang'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  setState(() {
                    state = "Penang";
                  });
                  Navigator.pop(context, StateMalaysia.Penang);
                },
                child: const Text('Penang'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  setState(() {
                    state = "Perak";
                  });
                  Navigator.pop(context, StateMalaysia.Perak);
                },
                child: const Text('Perak'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  setState(() {
                    state = "Perlis";
                  });
                  Navigator.pop(context, StateMalaysia.Perlis);
                },
                child: const Text('Perlis'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  setState(() {
                    state = "Putrajaya";
                  });
                  Navigator.pop(context, StateMalaysia.Putrajaya);
                },
                child: const Text('Putrajaya'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  setState(() {
                    state = "Sabah";
                  });
                  Navigator.pop(context, StateMalaysia.Sabah);
                },
                child: const Text('Sabah'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  setState(() {
                    state = "Sarawak";
                  });
                  Navigator.pop(context, StateMalaysia.Sarawak);
                },
                child: const Text('Sarawak'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  setState(() {
                    state = "Selangor";
                  });
                  Navigator.pop(context, StateMalaysia.Selangor);
                },
                child: const Text('Selangor'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  setState(() {
                    state = "Terengganu";
                  });
                  Navigator.pop(context, StateMalaysia.Terengganu);
                },
                child: const Text('Terengganu'),
              ),
            ],
          );
        });
  }

  _displayDialog3() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('City'),
            content: TextField(
              controller: cityController,
              decoration: InputDecoration(hintText: "City"),
            ),
            actions: <Widget>[
              // ignore: deprecated_member_use
              new FlatButton(
                child: new Text('SAVE'),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    city = cityController.text.toString();
                  });
                },
              )
            ],
          );
        });
  }

  _displayDialog4() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Postal Code'),
            content: TextField(
              controller: postalCodeController,
              decoration: InputDecoration(hintText: "Postal Code"),
            ),
            actions: <Widget>[
              // ignore: deprecated_member_use
              new FlatButton(
                child: new Text('SAVE'),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    postalcode = postalCodeController.text.toString();
                  });
                },
              )
            ],
          );
        });
  }

  _displayDialog5() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Detailed Address'),
            content: TextField(
              controller: detailAddressController,
              decoration: InputDecoration(hintText: "Detailed Address"),
            ),
            actions: <Widget>[
              // ignore: deprecated_member_use
              new FlatButton(
                child: new Text('SAVE'),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    detailedaddress = detailAddressController.text.toString();
                  });
                },
              )
            ],
          );
        });
  }

  _insertAddress() {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/271221/tactacumen/php/insert_address.php"),
        body: {
          "email": widget.user.email,
          "fullname": fullname,
          "phoneno": phoneNumber,
          "detailedaddress": detailedaddress,
          "postalcode": postalcode,
          "city": city,
          "state": state,
        }).then((response) {
      if (response.body == "Exist") {
        Fluttertoast.showToast(
            msg: "Exist.",
            toastLength: Toast.LENGTH_SHORT,
            fontSize: 16.0);
        setState(() {});
        return;
      } else if (response.body == "Success") {
        Fluttertoast.showToast(
            msg: "Success.",
            toastLength: Toast.LENGTH_SHORT,
            fontSize: 16.0);
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
