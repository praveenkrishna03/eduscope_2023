import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DocumentSearchPage extends StatefulWidget {
  final searchName,uid;
   DocumentSearchPage({required this.searchName,required this.uid});

  @override
  DocumentSearchPage_state createState() => DocumentSearchPage_state();
}

class DocumentSearchPage_state extends State<DocumentSearchPage> {
  
    @override
    Widget build(BuildContext context) {
      String uid=widget.uid;
    return Scaffold(
      body:StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('posts').orderBy('Post Name').startAt([widget.searchName]).endAt([widget.searchName + "\uf8ff"]) .snapshots(),
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