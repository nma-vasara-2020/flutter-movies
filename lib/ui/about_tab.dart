import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "assets/nma-logo.png",
            width: 250,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "National Student Academy (Nacionalinė moksleivių akademija, or NMA) is a unique institution of supplementary education intended for gifted Lithuanian children to promote their talents in academic range and music. More than 300 most talented children from different parts of Lithuania study in this Academy functioning for the tenth year.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton.icon(
                onPressed: () => launch("https://www.nmakademija.lt/eng/"),
                icon: Icon(Icons.public),
                label: Text("Website"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () => launch("https://www.facebook.com/nmakademija"),
                child: Text("Facebook")
              ),
            ),
          ],
        ),
      ],
    );
  }
}
