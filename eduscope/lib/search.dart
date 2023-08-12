import 'package:flutter/material.dart';


class SearchPage extends StatefulWidget {
  @override
  SearchPage_state createState() => SearchPage_state();
}

class SearchPage_state extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
          child: Text(
        'Search Page',
        style: TextStyle(color: Colors.white),
      )),
      
    );
  }
}