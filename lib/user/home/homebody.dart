import 'package:flutter/material.dart';
import 'package:tactacumen/user/home/loadtype.dart';
import 'package:tactacumen/user/home/appbar.dart';
import 'package:tactacumen/user/home/sellerpick.dart';
import 'package:tactacumen/sizeconfig.dart';
import 'package:tactacumen/user/drawer/mydrawer.dart';
import 'package:tactacumen/user/home/user.dart';

class HomeBody extends StatefulWidget {
  final User user;
  const HomeBody({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  double screenHeight, screenWidth;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar(context, widget.user),
      drawer: myDrawer(context, widget.user),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenWidth(15),
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF4A3298),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text.rich(TextSpan(
                  text: "A Summer Surprise\n",
                  style: TextStyle(color: Colors.white),
                  children: [
                    TextSpan(
                        text: "Discount 10%",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold))
                  ])),
            ),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            Column(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Special for you",
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(18),
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ],
                    )),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    GestureDetector(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (content) => LoadType(
                                    prtype: 'Malcomair', user: widget.user)))
                      },
                      child: SpecialOfferCard(
                        image: "assets/images/Image Banner 1.png",
                        category: "Malcomair Air Compressor",
                        numOfTypes: 11,
                        press: () {},
                      ),
                    ),
                    GestureDetector(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (content) => LoadType(
                                    prtype: 'Tacumen', user: widget.user)))
                      },
                      child: SpecialOfferCard(
                        image: "assets/images/Image Banner 2.png",
                        category: "Tacumen Air \nCompressor",
                        numOfTypes: 21,
                        press: () {},
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenHeight(20),
                    ),
                  ]),
                )
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Seller Pick",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ],
                )),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                ...List.generate(
                    demoProducts.length,
                    (index) => ProductCard(
                          product: demoProducts[index],
                        ))
              ]),
            ),
          ],
        ),
      )),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    this.width = 140,
    this.aspectRetion = 1.02,
    @required this.product,
  }) : super(key: key);

  final double width, aspectRetion;
  final SellerPick product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: Column(children: [
          AspectRatio(
              aspectRatio: aspectRetion,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF979797).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue[100],
                      blurRadius: 30.0,
                      spreadRadius: 0.0,
                      offset: Offset(2.0, 2.0),
                    )
                  ],
                ),
                child: Image.asset(product.images[0]),
              )),
          const SizedBox(height: 5),
          Text(
            product.title,
            style: TextStyle(color: Colors.black),
            maxLines: 2,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("RM " + "${product.price.toStringAsFixed(2)}",
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFF7643))),
          ])
        ]),
      ),
    );
  }
}

class AllProductCard extends StatefulWidget {
  const AllProductCard({
    Key key,
    this.width = 140,
    this.aspectRetion = 1.02,
    this.screenWidth,
    this.name,
    this.price,
    this.image,
  }) : super(key: key);

  final double width, aspectRetion;
  final screenWidth, name, price, image;

  @override
  _AllProductCardState createState() => _AllProductCardState();
}

class _AllProductCardState extends State<AllProductCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(widget.width),
        child: Column(children: [
          AspectRatio(
              aspectRatio: widget.aspectRetion,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF979797).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue[100],
                      blurRadius: 30.0,
                      spreadRadius: 0.0,
                      offset: Offset(2.0, 2.0),
                    )
                  ],
                ),
                child: widget.image,
              )),
          const SizedBox(height: 5),
          Text(
            widget.name,
            style: TextStyle(color: Colors.black),
            maxLines: 2,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("RM " + widget.price,
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFF7643))),
            Container(
              width: getProportionateScreenWidth(28),
              height: getProportionateScreenWidth(28),
              decoration: BoxDecoration(
                color: Color(0xFF979797).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.favorite, color: Colors.grey),
            ),
          ])
        ]),
      ),
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key key,
    @required this.category,
    @required this.image,
    @required this.numOfTypes,
    @required this.press,
  }) : super(key: key);
  final String category, image;
  final int numOfTypes;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(240),
        height: getProportionateScreenWidth(120),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(children: [
              Image.asset(image, fit: BoxFit.cover),
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color(0xFF343434).withOpacity(0.4),
                      Color(0xFF343434).withOpacity(0.15),
                    ])),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15),
                    vertical: getProportionateScreenWidth(10)),
                child: Text.rich(
                    TextSpan(style: TextStyle(color: Colors.white), children: [
                  TextSpan(
                      text: "$category\n",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(18),
                        fontWeight: FontWeight.bold,
                      )),
                  TextSpan(text: "$numOfTypes Types"),
                ])),
              )
            ])),
      ),
    );
  }
}
