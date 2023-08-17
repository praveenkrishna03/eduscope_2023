import 'dart:io';
import 'dart:typed_data';

import 'package:eduscope_2023/upload_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class FeedPage extends StatefulWidget {
  final String uid;
  FeedPage({required this.uid});
  @override
  FeedPage_state createState() => FeedPage_state();
}

class FeedPage_state extends State<FeedPage> {

  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       leading:
            IconButton(onPressed: () {
                Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UploadPage(uid:widget.uid),
                            ),
                          );
            }, icon: const Icon(Icons.add_circle)),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
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
      body: 
      Center(
          child: Text(
        'Feed Page',
        style: TextStyle(color: Colors.white),
      )));
    
  }
}