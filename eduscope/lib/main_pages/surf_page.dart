import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduscope_2023/reels_display.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SurfPage extends StatefulWidget {
  @override
  SurfPage_state createState() => SurfPage_state();
}

class SurfPage_state extends State<SurfPage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance.collection('reels').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text('No data available.'),
                );
              } else {
                return PageView.builder(
                  scrollDirection: Axis.vertical,
                  controller: _pageController,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return ReelsDisplay(snap: snapshot.data!.docs[index]);
                  },
                );
              }
            }));
  }
}
