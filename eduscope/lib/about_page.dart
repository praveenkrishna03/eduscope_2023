import 'package:flutter/material.dart';

class aboutPage extends StatefulWidget {
  @override
  aboutPage_State createState() => aboutPage_State();
}

class aboutPage_State extends State<aboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Image(
            alignment: Alignment.center,
            image: AssetImage(
                'images/logo.png'), // Specify the image file location here
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                child: Container(
              height: 50,
              width: 800,
              color: Color.fromARGB(255, 200, 199, 199),
              child: Center(
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.info,
                      size: 30,
                      color: Colors.blueGrey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'About',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                    ),
                  ],
                ),
              ),
            )),
            Container(
              height: 800,
              width: 1000,
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    child: Text(
                      '        Welcome to Eduscope, where learning meets collaboration! Our app is designed by students, for students, aiming to create a vibrant educational community that empowers you to share, learn, and connect like never before.',
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}