import 'package:flutter/material.dart';


class CommunityPage extends StatefulWidget {
  @override
  CommunityPage_state createState() => CommunityPage_state();
}

class CommunityPage_state extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        'Community Page',
        style: TextStyle(color: Colors.white),
      )),
    );
  }
}