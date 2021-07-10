import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tactacumen/sizeconfig.dart';
import 'package:tactacumen/user/home/user.dart';
import 'package:tactacumen/user/profile/orderstatus.dart';

class Categories extends StatefulWidget {
  final User user;

  const Categories({Key key, this.user}) : super(key: key);
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<Widget> _pages;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: _pages.elementAt(_selectedIndex),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _pages = <Widget>[
      OrderStatus(user: widget.user, status: "paid", title: "ORDER PAID"),
      OrderStatus(user: widget.user, status: "ship", title: "TO SHIP"),
      OrderStatus(user: widget.user, status: "pick", title: "TO PICK"),
      OrderStatus(
          user: widget.user, status: "receive", title: "ORDER RECEIVED"),
    ];
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/topay.svg", "text": "Order Paid"},
      {"icon": "assets/icons/toship.svg", "text": "To Ship"},
      {"icon": "assets/icons/topick.svg", "text": "To Pick"},
      {"icon": "assets/icons/toreceive.svg", "text": "Order Received"},
    ];
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
          (index) => CategoryCard(
            icon: categories[index]["icon"],
            text: categories[index]["text"],
            press: () {
              _onItemTapped(index);
            },
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: Color(0xFFFFECDF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(icon),
            ),
            SizedBox(height: 5),
            Text(text, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
