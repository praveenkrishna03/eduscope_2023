import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ReelsDisplay extends StatefulWidget {
  final DocumentSnapshot snap;

  ReelsDisplay({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  _ReelsDisplayState createState() => _ReelsDisplayState();
}

class _ReelsDisplayState extends State<ReelsDisplay> {
  late VideoPlayerController _controller;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    _controller = VideoPlayerController.network(
      widget.snap['Post URL'],
    );

    await _controller.initialize();
    setState(() {
      _controller.play();
      _controller.setLooping(true);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    String uid = user?.uid ?? '';

    return Center(
        child: Stack(
      fit: StackFit.expand,
      children: [
        _controller != null && _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Center(child: CircularProgressIndicator()),
        Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: 125,
              width: 500,
              color: Color.fromARGB(51, 0, 0, 0),
            )),
        Positioned(
            bottom: 75,
            left: 15,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(widget.snap['Profile URL']),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      widget.snap['Username'],
                      style: TextStyle(fontSize: 17),
                    ))
              ],
            )),
      ],
    ));
  }
}
