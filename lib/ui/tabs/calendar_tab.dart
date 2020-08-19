import 'package:flutter/material.dart';
import 'package:movies/api/movies_api_service.dart';
import 'package:movies/models/genre.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/ui/widgets/error_indicator.dart';
import 'package:movies/ui/widgets/loading_indicator.dart';
import 'package:movies/ui/widgets/movies_list.dart';

import '../../routes.dart';

class CalendarTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CalendarTabState();
  }
}

// App state https://flutter.dev/docs/development/ui/interactive
class CalendarTabState extends State<CalendarTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: EventList(),
    );
  }
}

class EventList extends StatelessWidget {
  final List<Event> events = [
    Event(DateTime(2020), "Pirmas", "Pirmas d"),
    Event(DateTime(2010), "Antras", "Antras d"),
    Event(DateTime(2011), "Trecias", "Trecias d"),
    Event(DateTime(1000), "Ketvirtas", "Ketvirtas d"),
  ];
  @override
  Widget build(BuildContext context) {
    events.sort((Event a, Event b) => a.time.compareTo(b.time));
    return ListView.builder(
      itemBuilder: (context, index) {
        return EventListViewCell(
          event: events[index],
        );
      },
      itemCount: events.length,
    );
  }
}

class EventListViewCell extends StatelessWidget {
  final event;

  const EventListViewCell({Key key, @required this.event})
      : assert(event != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.check_circle,
        color: Colors.green,
      ),
      title: Text(event.title),
      subtitle: Text(event.time.toString()),
      onTap: () => launchEventDetailScreen(context),
    );
  }

  launchEventDetailScreen(BuildContext context) {
    Navigator.pushNamed(
      context,
      Routes.ROUTE_EVENT_DETAILS,
      arguments: event,
    );
  }
}

class Event {
  final DateTime time;
  final String title, description;

  const Event(
    this.time,
    this.title,
    this.description,
  );
}
