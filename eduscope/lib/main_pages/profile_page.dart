import 'dart:ffi';
import 'dart:typed_data';
import '../users_post_card.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduscope_2023/post_list.dart';
import 'package:eduscope_2023/settings_home.dart';
import 'package:eduscope_2023/util.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../settings_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../post_list.dart';

class ProfilePage extends StatefulWidget {
  final String uid;

  ProfilePage({required this.uid});

  @override
  ProfilePage_state createState() => ProfilePage_state();
}

class ProfilePage_state extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  String _imgurl = '';
  Uint8List? _image;
  void selectImage() async {
    String uid = widget.uid;
    Uint8List img = await pickImage(ImageSource.gallery);

    String imgurl = await uploadImageToStorage('$uid', img);
    setState(() {
      _image = img;
      _imgurl = imgurl;
    });
    print(_imgurl);
    final cuser = FirebaseFirestore.instance
        .collection('user')
        .where('User Id', isEqualTo: uid);

    cuser.get().then((querySnapshot) {
      if (querySnapshot.size > 0) {
        final documentSnapshot = querySnapshot.docs[0];
        final documentReference = documentSnapshot.reference;

        documentReference.update({
          'Image URL': _imgurl, // Replace with the actual URL you want to add
        });
      }
    });
  }

  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String profile = await snapshot.ref.getDownloadURL();
    return profile;
  }

  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 4, vsync: this); // Initialize the TabController
  }

  @override
  Widget build(BuildContext context) {
    String uid = widget.uid;

    /* final cuser= FirebaseFirestore.instance.collection('user').where('User Id',isEqualTo:uid);
      cuser.update(
        {
          'Name':'Pr',
        }
      );*/

    return Scaffold(
        appBar: AppBar(
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
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('user')
              .where('User Id', isEqualTo: widget.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            var document =
                snapshot.data!.docs.isNotEmpty ? snapshot.data!.docs[0] : null;
            String name = document?['Name'] as String? ?? 'No Name';
            String email = document?['Email'] as String? ?? 'No Email';
            String Profile_URL =
                document?['Image URL'] as String? ?? 'No Image';
            int followers = (document?['Followers'] as List).length;
            int following = (document?['Following'] as List).length;
            int posts = (document?['Posts']) ?? 0;

            return Scaffold(
              body: SingleChildScrollView(
                  child: Column(children: [
                Container(
                  height: 160,
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
                        top: 75,
                        left: 25,
                        child: IconButton(
                          onPressed: selectImage,
                          icon: Icon(
                            Icons.edit,
                            size: 25,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 25,
                        left: 300,
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SettingsHomePage(uid: uid),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.settings,
                            size: 25,
                          ),
                        ),
                      ),
                      Positioned(
                          top: 40,
                          left: 120,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                                child: Text(
                                  '$name',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: Text(
                                  '$email',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: Row(
                                  children: [
                                    Text('Posts'),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text('Followers'),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text('Following'),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text('$posts'),
                                    SizedBox(
                                      width: 60,
                                    ),
                                    Text('$followers'),
                                    SizedBox(
                                      width: 60,
                                    ),
                                    Text('$following'),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  child: Center(
                      child: Text(
                    'My Posts',
                    style: TextStyle(color: Colors.black),
                  )),
                  color: Colors.white,
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .where('User Id', isEqualTo: uid)
                      .snapshots(),
                  builder: (Context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
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
                          UserPostCard(snap: snapshot.data!.docs[index].data()),
                    );
                  },
                ),
              ])

                  /*SizedBox(
      child:Row(
        children: [

        ],
      )
              //top: 150,

              

              ),*/

                  ),
            );

            //String Name = document['Name'] as String? ?? 'No Name';
            //String Email = document['Email']as String? ?? 'No Email';
//String Name=document['Name']?? 'NULL';
          },
        ));
  }
}

class imagePosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace this with your actual content for the first tab
    return Scaffold(
      body: Center(
        child: Text("First Tab Content"),
      ),
    );
  }
}

class vidPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace this with your actual content for the first tab
    return Scaffold(
      body: Center(
        child: Text("Videos"),
      ),
    );
  }
}

class docPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace this with your actual content for the first tab
    return Scaffold(
      body: Center(
        child: Text("Documents"),
      ),
    );
  }
}

class savedPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace this with your actual content for the first tab
    return Scaffold(
      body: Center(
        child: Text("Saved"),
      ),
    );
  }
}
