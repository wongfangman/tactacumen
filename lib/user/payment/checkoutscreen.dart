import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ndialog/ndialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tactacumen/user/payment/delivery.dart';
import 'package:tactacumen/user/payment/paydetail.dart';
import 'package:tactacumen/user/payment/payscreen.dart';
import 'package:tactacumen/user/home/user.dart';
import 'mappage.dart';

class CheckOutScreen extends StatefulWidget {
  final User user;
  final double total;

  const CheckOutScreen({Key key, this.total, this.user}) : super(key: key);

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  int _radioValue = 0;
  String _delivery = "Pickup";
  bool _statusdel = false;
  bool _statuspickup = true;
  String _selectedtime = "09:00 A.M";
  String _curtime = "";
  String _name = "Click to set";
  String _phone = "Click to set";
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController _userlocctrl = new TextEditingController();
  String address = "";
  double screenHeight, screenWidth;
  SharedPreferences prefs;
  int checkAddress = 0;

  @override
  void initState() {
    super.initState();
    final now = new DateTime.now();
    _curtime = DateFormat("Hm").format(now);
    int cm = _convMin(_curtime);
    _selectedtime = _minToTime(cm);
    _loadPref();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    final now = new DateTime.now();
    String today = DateFormat('hh:mm a').format(now);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('PAYMENT CHECKOUT',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
          ],
        ),
        backgroundColor: Colors.blue[100],
        iconTheme: IconThemeData(color: Colors.black),
        toolbarHeight: 88,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 0),
                children: [
                  Container(
                    margin: EdgeInsets.all(2),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Text(
                            "CUSTOMER DETAILS",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(flex: 3, child: Text("Email:")),
                              Container(
                                  height: 20,
                                  child: VerticalDivider(color: Colors.grey)),
                              Expanded(
                                flex: 7,
                                child: Text(widget.user.email),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(flex: 3, child: Text("Name:")),
                              Container(
                                  height: 20,
                                  child: VerticalDivider(color: Colors.grey)),
                              Expanded(
                                flex: 7,
                                child: GestureDetector(
                                    onTap: () => {nameDialog()},
                                    child: Text(widget.user.fullname)),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(flex: 3, child: Text("Phone:")),
                              Container(
                                  height: 20,
                                  child: VerticalDivider(color: Colors.grey)),
                              Expanded(
                                flex: 7,
                                child: GestureDetector(
                                    onTap: () => {phoneDialog()},
                                    child: Text(widget.user.phoneno)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 2,
                  ),
                  Container(
                    margin: EdgeInsets.all(2),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Column(
                        children: [
                          Text(
                            "DELIVERY METHOD",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Pickup"),
                              new Radio(
                                value: 0,
                                groupValue: _radioValue,
                                onChanged: (int value) {
                                  _handleRadioValueChange(value);
                                },
                              ),
                              Text("Delivery"),
                              new Radio(
                                value: 1,
                                groupValue: _radioValue,
                                onChanged: (int value) {
                                  _handleRadioValueChange(value);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 2,
                  ),
                  Visibility(
                    visible: _statuspickup,
                    child: Container(
                      margin: EdgeInsets.all(2),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: Column(
                          children: [
                            Image.asset("assets/images/pickup.png",
                                height: 200, width: 400),
                            Text(
                              "PICKUP TIME",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              margin: EdgeInsets.all(5),
                              width: 300,
                              child: Text(
                                  "Pickup time daily from 9.00 A.M to 5.00 P.M from our store. Please allow 15-30 minutes to prepare your order before pickup time."),
                            ),
                            SizedBox(height: 15),
                            Padding(
                              padding: EdgeInsets.fromLTRB(25, 2, 20, 2),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 5, child: Text("Current Time: ")),
                                  Container(
                                      height: 20,
                                      child:
                                          VerticalDivider(color: Colors.grey)),
                                  Expanded(
                                    flex: 5,
                                    child: Text(today),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(25, 2, 20, 2),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 5,
                                      child: Text("Set Pickup Time: ")),
                                  Container(
                                      height: 20,
                                      child:
                                          VerticalDivider(color: Colors.grey)),
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Text(
                                            _selectedtime,
                                          ),
                                          Container(
                                              child: IconButton(
                                                  iconSize: 32,
                                                  icon: Icon(Icons.timer),
                                                  onPressed: () =>
                                                      {_selectTime(context)})),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _statusdel,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Image.asset("assets/images/delivery.jpg",
                                height: 200, width: 400),
                            Text(
                              "DELIVERY ADDRESS",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                    flex: 6,
                                    child: Column(
                                      children: [
                                        TextField(
                                          controller: _userlocctrl,
                                          style: TextStyle(fontSize: 14),
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Search/Enter address'),
                                          keyboardType: TextInputType.multiline,
                                          minLines:
                                              4, //Normal textInputField will be displayed
                                          maxLines:
                                              4, // when user presses enter it will adapt to it
                                        ),
                                      ],
                                    )),
                                Container(
                                    height: 120,
                                    child: VerticalDivider(color: Colors.grey)),
                                Expanded(
                                    flex: 4,
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 150,
                                          child: ElevatedButton(
                                            onPressed: () =>
                                                {_getUserCurrentLoc()},
                                            child: Text("Location"),
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.grey,
                                          height: 2,
                                        ),
                                        Container(
                                          width: 150,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              Delivery _del =
                                                  await Navigator.of(context)
                                                      .push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MapPage(),
                                                ),
                                              );
                                              setState(() {
                                                _del == null
                                                    ? _userlocctrl.text =
                                                        "No location selected"
                                                    : _userlocctrl.text =
                                                        _del.address;
                                              });
                                            },
                                            child: Text("Map"),
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 2,
                  ),
                  SizedBox(height: 10),
                  Container(
                      child: Column(
                    children: [
                      Text(
                        "TOTAL AMOUNT PAYABLE",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "RM " + widget.total.toStringAsFixed(2),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                      Container(
                        width: screenWidth / 2.5,
                        child: ElevatedButton(
                          onPressed: () {
                            if (checkAddress == 1 &&
                                (_userlocctrl.text == "No location selected" ||
                                    _userlocctrl.text == "")) {
                              Fluttertoast.showToast(
                                  msg: "No location selected",
                                  toastLength: Toast.LENGTH_SHORT,
                                  fontSize: 16.0);
                              return;
                            }
                            {
                              _paynowDialog();
                            }
                          },
                          child: Text("PAY NOW"),
                        ),
                      )
                    ],
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 0:
          checkAddress = 0;
          _delivery = "Pickup";
          _statusdel = false;
          _statuspickup = true;
          setPickupExt();
          break;
        case 1:
          checkAddress = 1;
          _delivery = "Delivery";
          _statusdel = true;
          _statuspickup = false;
          break;
      }
    });
  }

  void setPickupExt() {
    final now = new DateTime.now();
    _curtime = DateFormat("Hm").format(now);
    int cm = _convMin(_curtime);
    _selectedtime = _minToTime(cm);
    setState(() {});
  }

  Future<Null> _selectTime(BuildContext context) async {
    TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
    final now = new DateTime.now();
    String year = DateFormat('y').format(now);
    String month = DateFormat('M').format(now);
    String day = DateFormat('d').format(now);

    String _hour, _minute, _time = "";
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ':' + _minute;
        _selectedtime = _time;
        _curtime = DateFormat("Hm").format(now);

        _selectedtime = formatDate(
            DateTime(int.parse(year), int.parse(month), int.parse(day),
                selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
        int ct = _convMin(_curtime);
        int st = _convMin(_time);
        int diff = st - ct;
        if (diff < 30) {
          Fluttertoast.showToast(
              msg: "Invalid time selection",
              toastLength: Toast.LENGTH_SHORT,
              fontSize: 16.0);
          _selectedtime = _minToTime(ct);
          setState(() {});
          return;
        }
      });
  }

  int _convMin(String c) {
    var val = c.split(":");
    int h = int.parse(val[0]);
    int m = int.parse(val[1]);
    int tmin = (h * 60) + m;
    return tmin;
  }

  String _minToTime(int min) {
    var m = min + 30;
    var d = Duration(minutes: m);
    List<String> parts = d.toString().split(':');
    String tm = '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
    return DateFormat.jm().format(DateFormat("hh:mm").parse(tm));
  }

  void nameDialog() {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Your Name?',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                actions: <Widget>[
                  TextField(
                    controller: nameController,
                    style: TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Enter Name'),
                    keyboardType: TextInputType.name,
                  ),
                  TextButton(
                    child: Text("Ok"),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      _name = nameController.text;
                      prefs = await SharedPreferences.getInstance();
                      await prefs.setString("name", _name);
                      setState(() {});
                    },
                  ),
                ]),
        context: context);
  }

  void phoneDialog() {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Your Phone?',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                actions: <Widget>[
                  TextField(
                    controller: phoneController,
                    style: TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Enter Name'),
                    keyboardType: TextInputType.phone,
                  ),
                  TextButton(
                    child: Text("Ok"),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      _phone = phoneController.text;

                      prefs = await SharedPreferences.getInstance();
                      await prefs.setString("phone", _phone);

                      setState(() {});
                    },
                  ),
                ]),
        context: context);
  }

  Future<void> _loadPref() async {
    prefs = await SharedPreferences.getInstance();
    _name = prefs.getString("name") ?? 'Click to set';
    _phone = prefs.getString("phone") ?? 'Click to set';
    setState(() {});
  }

  _getUserCurrentLoc() async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: Text("Searching address"), title: Text("Locating..."));
    progressDialog.show();
    await _determinePosition().then((value) => {_getPlace(value)});
    setState(
      () {},
    );
    progressDialog.dismiss();
  }

  void _getPlace(Position pos) async {
    List<Placemark> newPlace =
        await placemarkFromCoordinates(pos.latitude, pos.longitude);

    Placemark placeMark = newPlace[0];
    String name = placeMark.name.toString();
    String subLocality = placeMark.subLocality.toString();
    String locality = placeMark.locality.toString();
    String administrativeArea = placeMark.administrativeArea.toString();
    String postalCode = placeMark.postalCode.toString();
    String country = placeMark.country.toString();
    address = name +
        "," +
        subLocality +
        ",\n" +
        locality +
        "," +
        postalCode +
        ",\n" +
        administrativeArea +
        "," +
        country;
    _userlocctrl.text = address;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void _paynowDialog() {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Pay RM ' + widget.total.toStringAsFixed(2) + "?",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text("Yes"),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      PayDetails _payDetails = new PayDetails(
                          widget.user.email,
                          widget.user.phoneno,
                          widget.user.fullname,
                          widget.total.toString());
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              PayScreen(paydetails: _payDetails),
                        ),
                      );
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
}
