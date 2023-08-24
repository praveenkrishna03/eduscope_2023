import 'package:eduscope_2023/about_page.dart';
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
              height: 160,
            ),
            Container(
              height: 600,
              width: 800,
              decoration: ShapeDecoration(
                  color: Color(0xFFEFECEC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  )),
              child: Column(
                children: [
                  SizedBox(
                      child: Container(
                    height: 50,
                    width: 800,
                    decoration: ShapeDecoration(
                        color: Color.fromARGB(255, 200, 199, 199),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        )),
                    child: Center(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.settings,
                            size: 30,
                            color: Colors.blueGrey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Settings',
                            style:
                                TextStyle(color: Colors.blueGrey, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  )),
                  TextButton(
                    onPressed: () {},
                    child: SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.person,
                            color: const Color.fromARGB(255, 155, 162, 165),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Account',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(Icons.chat_bubble,
                              color: const Color.fromARGB(255, 155, 162, 165)),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Chat Options',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(Icons.interests,
                              color: const Color.fromARGB(255, 155, 162, 165)),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Interests',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(Icons.notifications_active,
                              color: const Color.fromARGB(255, 155, 162, 165)),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Notification Settings',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(Icons.download,
                              color: const Color.fromARGB(255, 155, 162, 165)),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Download Settings',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(Icons.support,
                              color: const Color.fromARGB(255, 155, 162, 165)),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Help',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => aboutPage(),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(Icons.info,
                              color: const Color.fromARGB(255, 155, 162, 165)),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'About',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(Icons.logout,
                              color: const Color.fromARGB(255, 155, 162, 165)),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Log Out',
                            style: TextStyle(color: Colors.red, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}