

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduscope_2023/feed_post_card.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileViewPage extends StatefulWidget {
  final user_uid,imgurl;
  ProfileViewPage({required this.user_uid,required this.imgurl,});
  
  @override
  ProfileViewPage_state createState() => ProfileViewPage_state();
}

class ProfileViewPage_state extends State<ProfileViewPage> {
  final FirebaseAuth _auth=FirebaseAuth.instance;
  //final FirebaseStorage _storage=FirebaseStorage.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  //bool isfollowing=false;





  Future<void> followUser(String uid, String user_uid) async {
  try {
    // Retrieve the current user's document from Firestore
    var querySnapshot = await _firestore
        .collection("user")
        .where("User Id", isEqualTo: uid)
        .get();

    var querySnapshot_user = await _firestore
        .collection("user")
        .where("User Id", isEqualTo: user_uid)
        .get();

    

    if (querySnapshot.docs.isNotEmpty) {
      print('Document exists on the database');
      var documentSnapshot = querySnapshot.docs[0];
      var documentSnapshot_user=querySnapshot_user.docs[0];
      List<dynamic> followingList = documentSnapshot['Following'];
      
      
      if (followingList.contains(user_uid)) {
        // If the target user is already followed, unfollow them
        _firestore.collection("user").doc(documentSnapshot.id).update({
          'Following': FieldValue.arrayRemove([user_uid])
        });

        // Also remove the current user from the target user's followers list
        _firestore.collection("user").doc(documentSnapshot_user.id).update({
          'Followers': FieldValue.arrayRemove([uid])
        });
      } else {
        // If the target user is not followed, follow them
        _firestore.collection("user").doc(documentSnapshot.id).update({
          'Following': FieldValue.arrayUnion([user_uid])
        });

        // Also add the current user to the target user's followers list
        _firestore.collection("user").doc(documentSnapshot_user.id).update({
          'Followers': FieldValue.arrayUnion([uid])
        });
        
      }
    } else {
      print('Document not found');
    }
   

  } catch (error) {
    print('Error: $error');
  }
}


  /*Future <void> followUser(
      String uid,
      String user_uid,
    )async{
      try{

        //final doc = FirebaseFirestore.instance.collection('posts').where('User Id', isEqualTo:uid);
        DocumentSnapshot snap=await _firestore.collection('user').doc(uid).get();
        List user_following=(snap.data()! as dynamic)['Following'];
        if(user_following.contains(user_uid)){
          await _firestore.collection('user').doc(uid).update({
            'Following':FieldValue.arrayRemove([user_uid])
          });

          await _firestore.collection('user').doc(user_uid).update({
            'Follwers':FieldValue.arrayRemove([uid])
          });
        }
        else{
          await _firestore.collection('user').doc(uid).update({
            'Following':FieldValue.arrayUnion([user_uid])
          });

          await _firestore.collection('user').doc(user_uid).update({
            'Followers':FieldValue.arrayUnion([uid])
          });
          
        }

      }
      catch(e){
          print(e);

      }
      
    }*/

  
  
  @override
  Widget build(BuildContext context) {
   
User? user=_auth.currentUser;
String uid = user?.uid ?? '';
String user_uid = widget.user_uid ?? '';
    
  
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
        stream: FirebaseFirestore.instance.collection('user').where('User Id',isEqualTo: user_uid).snapshots(),
        
          builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
             var document = snapshot.data!.docs.isNotEmpty ? snapshot.data!.docs[0] : null;
             if(document==null){
              return Center(child: Text('No user data available.'));

             }
        String name = document['Name'] ?? 'No Name';
        String email = document['Email'] ?? 'No Email';
        String Profile_URL =document['Image URL'] ??'No Image';
        var followers = (document['Followers'] as List).length ;
        var following = (document['Following'] as List).length ;
        bool isfollowing=document['Followers'].contains(uid);
        var post=document['Posts'] ??0;
        
          
        
        

      
        //bool isfollowing = (document['Following'] as List?)?.contains(uid) ?? false;
        

        
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
                      Text('$post'),
                      SizedBox(width: 60,),
                      Text('$followers'),
                      SizedBox(width: 60,),
                      Text('$following'),
                    ],
                  ),
                ),
                

                
              

            
            
            
            isfollowing?Center(child:ElevatedButton(
  onPressed: () {
    if (uid != null && user_uid != null) {
      followUser(uid, user_uid);
    } else {
      // Handle the case where widget.uid or widget.user_uid is null
    }
  },
  child: Container(
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
    child: Text('Unfollow'),
  ),
  
)
):
            Center(child:ElevatedButton(
              
  onPressed: () {
    
    if (uid != null && user_uid != null) {
      followUser(uid, user_uid);
            print(uid);
    print(user_uid);
    } else {

      // Handle the case where widget.uid or widget.user_uid is null
    }
  },
  child: Container(
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
    child: Text('Follow'),
  ),
),

)
                        
                ],
              ),
            ), 
          ],
        ),
      ),
    Container(height: 50,
      child: Center(child:Text('Posts',style: TextStyle(color: Colors.black),)),color: Colors.white,),
      StreamBuilder(

        stream: FirebaseFirestore.instance.collection('posts').where('User Id',isEqualTo: uid).snapshots(),
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
             FeedPostCard(snap: snapshot.data!.docs[index],),
          
        );
          
        },
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