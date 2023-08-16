

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
        return Scaffold(
  body:SingleChildScrollView(
  child:Column(
    children: [
      Container(
        height: 150,
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
              top: 30,
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                  
                children: [
                  Text(
                    
                    '$name',
                    style: TextStyle(
                        
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '$email',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 80,
              left: 115,
            child:Row( children:[           SizedBox(
              //top: 80,
              //left: 120,
              child: Text('Posts',
              style:TextStyle(
                fontSize: 16
              )),
            ),
            SizedBox(width: 20),
            SizedBox(
              //top: 80,
              //left: 180,
              child: Text('Followers',
              style:TextStyle(
                fontSize: 16
              )),
            ),SizedBox(width: 20),
            SizedBox(
              //top: 80,
              //left: 265,
              child: Text('Following',
              style:TextStyle(
                fontSize: 16
              )),
            )])
        
            ),
            Positioned(
              top: 100,
              left: 110,
            child:Row( children:[         SizedBox(width: 20,)  ,SizedBox(
              //top: 80,
              //left: 120,
              child: Text('0',
              style:TextStyle(
                fontSize: 16
              )),
            ),
            SizedBox(width: 60),
            SizedBox(
              //top: 80,
              //left: 180,
              child: Text('0',
              style:TextStyle(
                fontSize: 16
              )),
            ),SizedBox(width: 80),
            SizedBox(
              //top: 80,
              //left: 265,
              child: Text('0',
              style:TextStyle(
                fontSize: 16
              )),
            )])
        
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