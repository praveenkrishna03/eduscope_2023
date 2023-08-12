import 'package:flutter/material.dart';


class FeedPage extends StatefulWidget {
  @override
  FeedPage_state createState() => FeedPage_state();
}

class FeedPage_state extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        'Feed Page',
        style: TextStyle(color: Colors.white),
      )),
    );
  }
}