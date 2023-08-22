import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduscope_2023/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:video_player/video_player.dart';

class reelsDisplay extends StatelessWidget{
  final VideoPlayerController _controller = VideoPlayerController.network(
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  );
  reelsDisplay({super.key});

  @override
  void initState() {
  
   _controller.initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized.
        
      });
  }
  
  @override
  Widget build(BuildContext context){
    return Center(
      child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
             ,
        
     

    );
  
  }
  @override
  void dispose() {
  
    _controller.dispose();
  }

}