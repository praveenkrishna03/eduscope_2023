import 'dart:ffi';

import 'package:flutter/material.dart';


class FeedPostCard extends StatelessWidget{
  final snap;
  const FeedPostCard({Key?key,required this. snap}):super(key: key);
  @override

  Widget build(BuildContext context){

    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Container(
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
            SizedBox(height: 5,),
            SizedBox(
              child: Image.network(snap['Post URL'],fit: BoxFit.cover,),
              
            ) ,
            Row(
              children: [
                IconButton(onPressed: (){}, icon: Icon(Icons.thumb_up)),
                IconButton(onPressed: (){}, icon: Icon(Icons.thumb_down)),
                IconButton(onPressed: (){}, icon: Icon(Icons.share)),
                IconButton(onPressed: (){}, icon: Icon(Icons.drive_file_move)),
                IconButton(onPressed: (){}, icon: Icon(Icons.comment))
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