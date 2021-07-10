import 'package:flutter/material.dart';
import 'package:tactacumen/user/product/allproductsscreen.dart';
import 'package:tactacumen/user/cart/cartscreen.dart';
import 'package:tactacumen/user/home/homebody.dart';
import 'package:tactacumen/user/profile/profilescreen.dart';
import 'package:tactacumen/user/home/searchproduct.dart';
import 'package:tactacumen/sizeconfig.dart';
import 'user.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  const HomeScreen({Key key, this.user}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> _pages;

  @override
  void initState() {
    _pages = <Widget>[
      HomeBody(user: widget.user),
      AllProductsScreen(user: widget.user),
      CartScreen(user: widget.user),
      ProfileScreen(user: widget.user),
    ];
    super.initState();
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedIconTheme: IconThemeData(
          color: Colors.grey,
        ),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            label: 'Product',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'My Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      body: Container(child: _pages.elementAt(_selectedIndex)),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final User user;
  DataSearch({Key key, this.user});
  final products = [
    "Malcomair",
    "Tacumen",
    "Piston Air Compressor",
    "Screw Air Compressor",
  ];

  final recentProducts = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchProduct(prname: query, user: user);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentProducts
        : products.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: Icon(Icons.photo),
        title: InkWell(
          child: RichText(
              text: TextSpan(
                  text: suggestionList[index].substring(0, query.length),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  children: [
                TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey))
              ])),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
