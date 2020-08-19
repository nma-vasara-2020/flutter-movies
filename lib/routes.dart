import 'package:flutter/material.dart';
import 'package:movies/ui/tabs/calendar_tab.dart';

import 'models/movie.dart';
import 'ui/about_page.dart';
import 'ui/main_page.dart';
import 'ui/event_details_page.dart';

class Routes {
  static const ROUTE_MAIN = "main";
  static const ROUTE_ABOUT = "about";
  static const ROUTE_EVENT_DETAILS = "event_details";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ROUTE_MAIN:
        return MaterialPageRoute(builder: (context) {
          return MainPage();
        });
      case ROUTE_ABOUT:
        return MaterialPageRoute(builder: (context) {
          return AboutPage();
        });
      case ROUTE_EVENT_DETAILS:
        final Event event = settings.arguments;

        return MaterialPageRoute(builder: (context) {
          return EventDetailsPage(
            event: event,
          );
        });
      default:
        throw Exception("Unable to find route ${settings.name} in routes");
    }
  }
}
