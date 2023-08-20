import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduscope_2023/profile_view.dart';
import 'package:flutter/material.dart';


class FeedPostCard extends StatelessWidget{
  final snap;

  Future like_update()async{
    final cuser = FirebaseFirestore.instance.collection('posts').where('User Id', isEqualTo:snap['User Id']);

cuser.get().then((querySnapshot) {
  if (querySnapshot.size > 0) {
    final documentSnapshot = querySnapshot.docs[0];
    final documentReference = documentSnapshot.reference;

    documentReference.update({
      'Likes': snap['Likes']+1, // Replace with the actual URL you want to add
    });
  }

}
);
  }

  Future dislike_update()async{
    final cuser = FirebaseFirestore.instance.collection('posts').where('User Id', isEqualTo:snap['User Id']);

cuser.get().then((querySnapshot) {
  if (querySnapshot.size > 0) {
    final documentSnapshot = querySnapshot.docs[0];
    final documentReference = documentSnapshot.reference;

    documentReference.update({
      'Dislikes': snap['Dislikes']+1, // Replace with the actual URL you want to add
    });
  }

}
);
  }
  
  const FeedPostCard({Key?key,required this. snap}):super(key: key);
  @override

  Widget build(BuildContext context){

    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            GestureDetector(
              onTap:(() {
                
              Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileViewPage(uid: snap['User Id'],imgurl: snap['Profile URL'],),
                            ),
              );
              }
              ),           
            child:Container(
              
              padding: const EdgeInsets.symmetric(
                vertical: 4,horizontal: 16,
              ).copyWith(right:0),
              
              child: Row(

                children: [
                  CircleAvatar(
                    
                    radius: 16,
                    backgroundImage: NetworkImage(snap['Profile URL']),
                  ),Expanded(
                       
                    child: Padding(padding: const EdgeInsets.only(left: 8),
                    child: Text(snap['Username'])
                    )
                    )
                ],
              ),
          
            ),
            ),
            SizedBox(height: 5,),
            SizedBox(
              child: Image.network(snap['Post URL'],fit: BoxFit.cover,),
              
            ) ,
            Row(
              children: [
                IconButton(onPressed: (){
                  like_update();
                }, icon: Icon(Icons.thumb_up)),
                IconButton(onPressed: (){
                  dislike_update();
                }, icon: Icon(Icons.thumb_down)),
                IconButton(onPressed: (){}, icon: Icon(Icons.share)),
                IconButton(onPressed: (){}, icon: Icon(Icons.drive_file_move)),
                IconButton(onPressed: (){}, icon: Icon(Icons.comment))
              ],
            ),
            Row(
              
              children: [
                SizedBox(width: 20,),
                Text(snap['Likes'].toString()),
                SizedBox(width: 40,),
                Text(snap['Dislikes'].toString()),
              ],
            ),

            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 8),
              child: RichText(text: TextSpan(
                children: [
                  TextSpan(
                text: snap['Username'],
                style: TextStyle(fontWeight: FontWeight.bold),
            ),TextSpan(
                text: snap['Post Name'],

            ),
            
            ])),
              
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(top: 4),
              child: Text('20-08-2023',),
            )
            
            
          ],
        ),
    );
  }
}