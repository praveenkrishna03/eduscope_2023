

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileViewPage extends StatefulWidget {
  final uid,imgurl;
  ProfileViewPage({required this.uid,required this.imgurl});
  
  @override
  ProfileViewPage_state createState() => ProfileViewPage_state();
}

class ProfileViewPage_state extends State<ProfileViewPage> {
  FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseStorage _storage=FirebaseStorage.instance;
  
  @override
  Widget build(BuildContext context) {
  
  return Scaffold(
    appBar: AppBar(
        leading:
            IconButton(onPressed: () {
              Navigator.pop(context);
            }, icon: const Icon(Icons.arrow_back)),
            actions: [
          IconButton(
              onPressed: () async {},
              icon: const Icon(Icons.more_vert))
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
    body:StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('user').where('User Id',isEqualTo:widget.uid).snapshots(),
        
          builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
             var document = snapshot.data!.docs.isNotEmpty ? snapshot.data!.docs[0] : null;
        String name = document?['Name'] as String? ?? 'No Name';
        String email = document?['Email'] as String? ?? 'No Email';
        String Profile_URL =document?['Image URL'] as String? ??'No Image';

        var postSnap= FirebaseFirestore.instance.collection('user').where('User Id',isEqualTo:widget.uid).get;
        
        return Scaffold(
  body:SingleChildScrollView(
  child:Column(
    children: [
      Container(
        height: 200,
        width: double.infinity,
        color: Color.fromRGBO(41, 41, 41, 0.85),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 25,
              left: 0,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(Profile_URL),
              ),
            ),
            
                        Positioned(
              top: 40,
              left: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: 20,
                child: Text('$name',
                style: TextStyle(
                        
                      color: Colors.white,
                      fontSize: 18,
                    ),),
                ),
                SizedBox(
                  height: 20,
                  child: Text('$email',
                  style: TextStyle(
                        
                      color: Colors.white,
                      fontSize: 14,
                    ),),
                ),
                SizedBox(
                  height: 40,
                  child: Row(
                    children: [
                      Text('Posts'),
                      SizedBox(width: 20,),
                      Text('Followers'),
                      SizedBox(width: 20,),
                      Text('Following'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 15,),
                      Text('0'),
                      SizedBox(width: 60,),
                      Text('0'),
                      SizedBox(width: 60,),
                      Text('0'),
                    ],
                  ),
                ),

                
              

            
            
            
            Center(child:ElevatedButton(onPressed: (){
          

            },
            child:Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
            child:Text('Follow')),)),

                ],
              ),
            ), 
          ],
        ),
      ),
    SizedBox(
      child:Row(
        children: [

        ],
      )
              //top: 150,

              

              ),
    ],
    
  ),
)
        );

         
          
      
        
        
          },
      )
          
    );

  
  }
}