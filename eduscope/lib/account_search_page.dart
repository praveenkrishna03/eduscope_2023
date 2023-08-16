import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountSearchPage extends StatefulWidget {
 final searchName;
 AccountSearchPage({required this.searchName});

  @override
  AccountSearchPage_state createState() => AccountSearchPage_state();
}

class AccountSearchPage_state extends State<AccountSearchPage> {
    
    
    @override
    Widget build(BuildContext context) {
      
    return Scaffold(
      body:StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('user').orderBy('Name').startAt([widget.searchName]).endAt([widget.searchName + "\uf8ff"]) .snapshots(),
        builder: (context , Snapshot){
          return ListView.builder(
          itemCount:Snapshot.data!.docs.length,
          itemBuilder: ((context, index){
            var data=Snapshot.data!.docs[index];
            return ListTile(
              leading: CircleAvatar(radius: 24,backgroundImage: NetworkImage(data['Image URL'!]),)
              ,
              title: Text(data['Name']),
              subtitle: Text(data['Email']),
            );
          }),
        );

        }
        
      )
    );
  }
}