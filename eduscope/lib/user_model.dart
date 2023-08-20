import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel{
  final String name;
  final String email;
  final String password;
  final String imageurl;
  final String uid;
  final List followers;
  final List following;
  final int posts;

  const UserModel({
    required this.email,
    required this.name,
    required this.password,
    required this.imageurl,
    required this.uid,
    required this.followers,
    required this.following,
    required this.posts,
  });
  Map<String , dynamic>toJson()=>{
  "Email": email,
  "Name": name,
  "Image URL":imageurl,
  "Password":password,
  "User Id":uid,
  "Followers":followers,
  "Following":following,
  "Posts":posts,

};
    static UserModel fromSnap(DocumentSnapshot snap){
        var snapshot=snap.data() as Map<String,dynamic>;
        return UserModel(
          name:snapshot['Name'],
          email:snapshot['Email'],
  
  imageurl:snapshot['Image URL'],
  password:snapshot['Password'],
  uid:snapshot['User Id'],
  followers:snapshot['Followers'],
  following:snapshot['Following'],
  posts: snapshot['Post'],
        );
    }

}

