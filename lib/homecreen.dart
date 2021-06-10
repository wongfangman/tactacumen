import 'package:flutter/material.dart';
import 'package:tactacumen/homebody.dart';
import 'package:tactacumen/searchproduct.dart';
import 'package:tactacumen/loginscreen.dart';
import 'package:tactacumen/sizeconfig.dart';
import 'user.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:page_transition/page_transition.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  const HomeScreen({Key key, this.user}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/tactacumen.png',
              fit: BoxFit.contain,
              height: 40,
            ),
            Text(' TACT ACUMEN',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
          ],
        ),
        backgroundColor: Colors.blue[100],
        iconTheme: IconThemeData(color: Colors.black),
        toolbarHeight: 88,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          ),
          IconButton(
            onPressed: () => {},
            icon: Icon(Icons.notifications),
          ),
        ],
      ),
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
            icon: Icon(Icons.favorite),
            label: 'Favorite',
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
      drawer: Drawer(
        child: ListView(children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            height: 150,
            child: DrawerHeader(
              child: ListTile(
                trailing: Icon(
                  Icons.chevron_right,
                  size: 28,
                ),
                subtitle: GestureDetector(
                  onTap: () {},
                  child: Text(
                    "See Profile",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                title: Text(
                  "Your Name",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                leading: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).platform == TargetPlatform.android
                          ? Colors.white
                          : Colors.blue[100],
                  backgroundImage: AssetImage("assets/images/profile.png"),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue[100],
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Feather.home,
              color: Colors.black,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: HomeScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Feather.search, color: Colors.black),
            title: Text('Search',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            onTap: () {
              showSearch(context: context, delegate: DataSearch());
            },
          ),
          ListTile(
            leading: Icon(Feather.bell, color: Colors.black),
            title: Text('Notifications',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Feather.shopping_cart, color: Colors.black),
            title: Text('Shopping Cart',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Feather.list, color: Colors.black),
            title: Text('My Orders',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Feather.award, color: Colors.black),
            title: Text('Points',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Feather.message_circle, color: Colors.black),
            title: Text('Support',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Feather.help_circle, color: Colors.black),
            title: Text('Help',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Feather.settings, color: Colors.black),
            title: Text('Settings',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Feather.x_circle, color: Colors.black),
            title: Text('Log Out',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (content) => LoginScreen()));
            },
          ),
        ]),
      ),
      body: HomeBody(),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
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
    return SearchProduct(prname: query);
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
