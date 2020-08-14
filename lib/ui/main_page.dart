import 'package:flutter/material.dart';

import 'tabs/about_tab.dart';
import 'tabs/popular_movies_tab.dart';
import 'tabs/random_movies_tab.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        centerTitle: true,
      ),
      body: getTabBody(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.explore),
            title: Text('Discover'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.movie),
            title: Text('Popular'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.help),
            title: Text('About'),
          ),
        ],
      ),
    );
  }

  Widget getTabBody() {
    switch (_currentIndex) {
      case 0:
        return RandomMoviesTab();
      case 1:
        return PopularMoviesTab();
      case 2:
        return AboutTab();
      default:
        throw ArgumentError("Tab with index $_currentIndex doesn't exist");
    }
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
