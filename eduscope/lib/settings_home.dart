import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsHomePage extends StatefulWidget {
  final String uid;
  
  SettingsHomePage({required this.uid});

  @override
  SettingsHomePage_State createState() => SettingsHomePage_State();
}


class SettingsHomePage_State extends State<SettingsHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            IconButton(onPressed: () {
              Navigator.pop(context);
            }, icon: const Icon(Icons.arrow_back)),
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
        Container(
          color: Colors.white,
          
          ),
        
      
    );
  }
}