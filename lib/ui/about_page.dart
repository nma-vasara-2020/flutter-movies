import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About NMA"),
      ),
      body: Container(child: AboutPageBody()),
    );
  }
}

class AboutPageBody extends StatelessWidget {
  static const NMA_WEBSITE_URL = "https://www.nmakademija.lt/eng/";
  static const NMA_FACEBOOK_URL = "https://www.facebook.com/nmakademija/";

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
                onPressed: _launchWebsite,
                icon: Icon(Icons.public),
                label: Text("Website"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: _launchFacebook,
                child: Text("Facebook"),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<bool> _launchWebsite() async {
    return await _launchURL(NMA_WEBSITE_URL);
  }

  Future<bool> _launchFacebook() async {
    return await _launchURL(NMA_FACEBOOK_URL);
  }

  // https://pub.dev/packages/url_launcher
  Future<bool> _launchURL(String url) async {
    if (await canLaunch(url)) {
      return await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
