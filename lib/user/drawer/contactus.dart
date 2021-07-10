import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('CONTACT US',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
          ],
        ),
        backgroundColor: Colors.blue[100],
        iconTheme: IconThemeData(color: Colors.black),
        toolbarHeight: 88,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
                color: Colors.blue[100],
                width: double.infinity,
                height: 250,
                child: Column(children: [
                  Image.asset("assets/images/contactus.png",
                      height: 250, width: 600),
                ])),
            Column(
              children: [
                SizedBox(height: 10),
                Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40.0,
                ),
                SizedBox(height: 10),
                Text(
                  'Address',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'No. 2A, Lorong IKS Simpang Empat N,',
                ),
                Text(
                  'Taman IKS Simpang Empat,',
                ),
                Text(
                  '14100 Simpang Ampat, Penang.',
                ),
                SizedBox(height: 15),
                Icon(
                  Icons.phone_iphone,
                  color: Colors.red,
                  size: 40.0,
                ),
                SizedBox(height: 10),
                Text(
                  'Eric Wong',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '019-4482716',
                ),
                SizedBox(height: 15),
                Icon(
                  Icons.schedule,
                  color: Colors.red,
                  size: 40.0,
                ),
                SizedBox(height: 10),
                Text(
                  'Monday - Friday',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '9am - 6pm',
                ),
                SizedBox(height: 15),
                Text(
                  'Saturday',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '9am - 1pm',
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
