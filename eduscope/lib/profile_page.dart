import 'package:flutter/material.dart';


class ProfilePage extends StatefulWidget {
  @override
  ProfilePage_state createState() => ProfilePage_state();
}

class ProfilePage_state extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        'Profile Page',
        style: TextStyle(color: Colors.white),
      )),
    );
  }
}