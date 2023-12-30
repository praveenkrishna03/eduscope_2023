import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MediaSearchPage extends StatefulWidget {
  final searchName,uid;
   MediaSearchPage({required this.searchName,required this.uid});


  @override
  MediaSearchPage_state createState() => MediaSearchPage_state();
}

class MediaSearchPage_state extends State<MediaSearchPage> {
    @override
    Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('posts')/*.where('type',isEqualTo: 'image',)*/.orderBy('Post Name').startAt([widget.searchName]).endAt([widget.searchName + "\uf8ff"]) .snapshots(),
        builder: (context , Snapshot){
          return ListView.builder(
          itemCount:Snapshot.data!.docs.length,
          itemBuilder: ((context, index){
            var data=Snapshot.data!.docs[index];
            return ListTile(
              onTap: () {
                
                
              },
              leading: CircleAvatar(radius: 24,backgroundImage: NetworkImage(data['Post URL'!]),)
              ,
              title: Text(data['Post Name']),
              
            );
          }),
        );

        }
        
      )
    );
  }
}