
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduscope_2023/feed_post_card.dart';
import 'package:eduscope_2023/upload_page.dart';
import 'package:flutter/cupertino.dart';
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
    String uid=widget.uid;
    
    

    return Scaffold(
      appBar: AppBar(
       leading:
            IconButton(onPressed: () {
                  showModalBottomSheet(context: context, builder: (BuildContext context){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                          children:[
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 10.0), // Adjust the padding
                                ),
                                onPressed:(){
                                  Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UploadPage(uid:widget.uid,type: 'image',),
                            ),
                          );

                              }, child: Row(
                                children: [
                                  SizedBox(width: 20,),
                                  Icon(Icons.image,color: Colors.white,),
                                  SizedBox(width: 10,),
                                  Text('Image',
                                  style: TextStyle(color: Colors.white),)

                                ],
                              )
                              ),
                              SizedBox(height: 20,),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 10.0), // Adjust the padding
                                ),
                                onPressed:(){
                                  Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UploadPage(uid:widget.uid,type: 'video',),
                            ),
                          );
                                

                              }, child: Row(
                                children: [
                                  SizedBox(width: 20,),
                                  Icon(Icons.video_file,color: Colors.white,),
                                  SizedBox(width: 10,),
                                  Text('Video',style: TextStyle(color: Colors.white))

                                ],
                              )
                              ),
                              SizedBox(height: 20,),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 10.0), // Adjust the padding
                                ),
                                onPressed:(){

                                  Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UploadPage(uid:widget.uid,type: 'document',),
                            ),
                          );
                              }, child: Row(
                                children: [
                                  SizedBox(width: 20,),
                                  Icon(Icons.upload_file,color: Colors.white,),
                                  SizedBox(width: 10,),
                                  Text('Document',style: TextStyle(color: Colors.white))

                                ],
                              )
                              ),


                          ]
                    );
                  });



                /*Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UploadPage(uid:widget.uid),
                            ),
                          );*/
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
      
      body:SingleChildScrollView(
      child:StreamBuilder(

        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (Context, AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) =>
 //             print(snapshot.data!.docs.length),
             FeedPostCard(snap: snapshot.data!.docs[index].data()),
          
        );
          
        },
        )
      )
    );
      
    
  }
}