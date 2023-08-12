import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SearchPage extends StatefulWidget {
  SearchPage({super.key});
  @override
  SearchPage_state createState() => SearchPage_state();
}

class SearchPage_state extends State<SearchPage> {
  var searchName="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.black,
        title: SizedBox(
          height: 40,
          child:TextField(
            onChanged: (value) {
              setState(() {
                searchName=value;
              });
            },
            decoration: InputDecoration( 
              border:OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
            contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
            filled: true,fillColor: Color.fromARGB(255, 109, 109, 109),
            hintText: 'Search',
            prefixIcon: Icon(
              Icons.search
            )
            ),
            
            
            ),
          )
        ),
      
       body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('user').orderBy('Name').startAt([searchName]).endAt([searchName + "\uf8ff"]) .snapshots(),
        builder: (context , Snapshot){
          return ListView.builder(
          itemCount:Snapshot.data!.docs.length,
          itemBuilder: ((context, index){
            var data=Snapshot.data!.docs[index];
            return ListTile(
              leading: CircleAvatar(radius: 24,backgroundImage: AssetImage('assets/logo.png'),)
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