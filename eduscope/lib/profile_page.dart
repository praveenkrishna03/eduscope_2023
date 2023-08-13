import 'dart:ffi';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduscope_2023/util.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'util.dart';

class ProfilePage extends StatefulWidget {
  @override
  ProfilePage_state createState() => ProfilePage_state();
}

class ProfilePage_state extends State<ProfilePage> {
  FirebaseAuth _auth=FirebaseAuth.instance;
  Uint8List? _image;
  void selectImage() async{
    Uint8List img= await pickImage(ImageSource.gallery);
    setState(() {
     _image= img; 
    });
  }
  
  
  @override
  
  Widget build(BuildContext context) {
    User? user=_auth.currentUser;
       String uid=user?.uid??'';
    
    return Scaffold(
      
      body:StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('user').where('User Id',isEqualTo:uid).snapshots(),
        
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
        return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: [
                Stack(
                  children:[
                    _image!=null?
                    CircleAvatar(
                      radius: 48,
                      backgroundImage: MemoryImage(_image!),
                    )
                :
                const CircleAvatar(
                  radius: 48,
                  backgroundImage: AssetImage(''),
                  
                ),
                Positioned(
                  left: 25,
                  top: 50,
                  
                  
                  child:IconButton(
                  
                  onPressed:selectImage,
                    icon:Icon(Icons.edit,
                    size: 24,
                    )
                    //Alignment:Alignment.bottomCenter,
                  ),),
                
                ]),

                SizedBox(
                  
                  child:
                Text('Name: $name'),
                ),
                SizedBox(child:Text('Email: $email')),
              ]
              
          
            ),
            
            
            
          );
        }
         
          //String Name = document['Name'] as String? ?? 'No Name';
          //String Email = document['Email']as String? ?? 'No Email';
//String Name=document['Name']?? 'NULL';
          
      
        
        
          ),
          
    );
    
  }
}