import 'package:crypto_app/views/home_page.dart';
import 'package:crypto_app/views/search_coins.dart';
import 'package:crypto_app/views/watch_list.dart';
import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _selectedIndex = 0;

  static final ScrollController homeController = ScrollController();

  static List<Widget> _widgetOptions = <Widget>[
    HomePage(controller: homeController,),
    SearchCoins(controller: homeController,),
    WatchList(controller: homeController,),
  ];

  void _onItemTapped(int index) {
    if (_selectedIndex == index) {
        homeController.animateTo(
         0.0,
         curve: Curves.easeOut,
         duration: const Duration(milliseconds: 300),
       );
         
    }
    else {
      setState(() {
      _selectedIndex = index;
    });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Crypto",
              style: TextStyle(color: Colors.green, fontFamily: "Roboto"),
            ),
            Text(
              "App",
              style: TextStyle(color: Colors.red, fontFamily: "Roboto"),
            )
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list, color: Colors.grey,),
            title: Text('Top Coins'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.grey,),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star, color: Colors.grey,),
            title: Text('Watchlist'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white70,
        onTap: _onItemTapped,
      ),
    );
  }
}