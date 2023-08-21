import 'package:eduscope_2023/community_page.dart';
import 'package:eduscope_2023/feed_page.dart';
import 'package:eduscope_2023/profile_page.dart';
import 'package:eduscope_2023/search.dart';
import 'package:eduscope_2023/surf_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';


class HomePage extends StatefulWidget {
  HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String uid='';
  final User? user = Auth().currentUser;
  FirebaseAuth _auth=FirebaseAuth.instance;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    User? user=_auth.currentUser;
       uid=user?.uid??'';

    final List<Widget> _pages = [
    FeedPage(uid:uid),
    SearchPage(uid:uid),
    SurfPage(),
    CommunityPage(),
    ProfilePage(uid:uid),
  ];

  
    return Scaffold(
      /*appBar: AppBar(
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.add_circle)),
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
      ),*/

      body: _pages[_currentIndex],
      /*Center(
          child: Text(
        user?.email ?? 'user email',
        style: TextStyle(color: Colors.white),
      ))*/
      

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromARGB(255, 68, 68, 68),
        selectedItemColor: Colors.grey, // Set selected icon color
        unselectedItemColor: Colors.white,
        iconSize: 40,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.travel_explore),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.surfing),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.diversity_3),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: '',
          ),
        ],
      ),
      //Center(child: Text(user?.email ?? 'user email')),
    );
  }
}


