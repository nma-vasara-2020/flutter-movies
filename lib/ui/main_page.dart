import 'package:flutter/material.dart';
import 'package:movies/routes.dart';

import 'tabs/movies_in_theater_tab.dart';
import 'tabs/popular_movies_tab.dart';
import 'tabs/discover_movies_tab.dart';

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
        // TODO Task 1
        // TODO Task 4
        title: Text("Hello world"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              Navigator.pushNamed(
                context,
                Routes.ROUTE_ABOUT,
              );
            },
          ),
        ],
      ),
      body: getTabBody(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.explore),
            title: Text('DISCOVER'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.movie),
            title: Text('POPULAR'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.local_movies),
            title: Text('IN THEATERS'),
          ),
        ],
      ),
    );
  }

  Widget getTabBody() {
    switch (_currentIndex) {
      case 0:
        return DiscoverMoviesTab();
      case 1:
        return PopularMoviesTab();
      case 2:
        return MoviesInTheaterTab();
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
