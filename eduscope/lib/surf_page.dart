import 'package:flutter/material.dart';


class SurfPage extends StatefulWidget {
  @override
  SurfPage_state createState() => SurfPage_state();
}

class SurfPage_state extends State<SurfPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        'Surf Page',
        style: TextStyle(color: Colors.white),
      )),
    );
  }
}