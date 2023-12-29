import 'package:eduscope_2023/reels_display.dart';
import 'package:flutter/material.dart';


class SurfPage extends StatefulWidget {
  @override
  SurfPage_state createState() => SurfPage_state();
}

class SurfPage_state extends State<SurfPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        children: [
           
        Container(
          color: Colors.amberAccent,
        ),
        Container(
          color: Colors.red,
        ),
        Container(
          color: Colors.blue,
        ),
        Container(
          color: Colors.green,
        ),reelsDisplay()
      ],
        
      )
    );
  }
}