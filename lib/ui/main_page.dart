import 'package:flutter/material.dart';
import 'package:movies/routes.dart';

import 'tabs/movies_in_theater_tab.dart';
import 'tabs/popular_movies_tab.dart';
import 'tabs/calendar_tab.dart';

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
        title: Text(getTabText()),
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
            icon: new Icon(Icons.calendar_today),
            title: Text('Programėlė'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.music_note),
            title: Text('Dainos'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.contacts),
            title: Text('Kontaktai'),
          ),
        ],
      ),
    );
  }

  String getTabText() {
    switch (_currentIndex) {
      case 0:
        return "Programėlė";
      case 1:
        return "Dainos";
      case 2:
        return "Kontaktai";
      default:
        throw ArgumentError("Tab text with index $_currentIndex doesn't exist");
    }
  }

  Widget getTabBody() {
    switch (_currentIndex) {
      case 0:
        return CalendarTab();
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
