import 'package:eduscope_2023/pdf_viewer.dart';
import 'package:eduscope_2023/profile_view.dart';
import 'package:eduscope_2023/widgets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class FeedPostCard extends StatelessWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final DocumentSnapshot snap;

  FeedPostCard({
    Key? key,
    required this.snap,
  }) : super(key: key);
  void likeUpdate(String postId) async {
    User? user = _auth.currentUser;
    String uid = user?.uid ?? '';

    CollectionReference postsCollection =
        FirebaseFirestore.instance.collection('posts');
    DocumentReference postRef = postsCollection.doc(postId);

    DocumentSnapshot postSnapshot = await postRef.get();
    List<dynamic> likes = postSnapshot['Likes'] ?? [];

    if (!likes.contains(uid)) {
      likes.add(uid);
      await postRef.update({'Likes': likes});
    }
  }

  void movePostToReported(String postId) async {
    // Get the post details from the 'posts' collection
    DocumentReference postRef =
        FirebaseFirestore.instance.collection('posts').doc(postId);
    DocumentSnapshot postSnapshot = await postRef.get();
    Map<String, dynamic> postData = postSnapshot.data() as Map<String, dynamic>;

    // Add the post details to the 'reported' collection
    CollectionReference reportedCollection =
        FirebaseFirestore.instance.collection('reported');
    await reportedCollection.add(postData);

    // Delete the post from the 'posts' collection
    await postRef.delete();
  }

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    String uid = user?.uid ?? '';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: (() {
              print(snap['User Id']);
              print(uid);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileViewPage(
                    user_uid: snap['User Id'],
                    imgurl: snap['Profile URL'],
                  ),
                ),
              );
            }),
            child: Container(
              //color: const Color.fromARGB(255, 126, 126, 126),
              decoration: ShapeDecoration(
                color: Color.fromARGB(255, 121, 120, 120),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(17),
                      topRight: Radius.circular(17)),
                ),
              ),

              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 16,
              ).copyWith(right: 0),

              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(snap['Profile URL']),
                  ),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(snap['Username'])))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          snap['type'] == 'document'
              ? GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PDFViewerPage(pdfURL: snap['Document URL']),
                      ),
                    );
                  },
                  child: Image.network(
                    snap['Post URL'],
                    fit: BoxFit.cover,
                  ),
                )
              : Image.network(
                  snap['Post URL'],
                  fit: BoxFit.cover,
                ),
          Container(
              decoration: ShapeDecoration(
                color: Color.fromARGB(255, 121, 120, 120),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(17),
                      bottomRight: Radius.circular(17)),
                ),
              ),
              child: Column(children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          // likeUpdate();
                          likeUpdate(snap.id);
                        },
                        icon: Icon(Icons.thumb_up)),
                    //IconButton(onPressed: (){

                    //}, icon: Icon(Icons.thumb_down)),
                    IconButton(
                        onPressed: () {
                          movePostToReported(snap.id);
                        },
                        icon: Icon(Icons.report)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.share)),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.drive_file_move)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.comment))
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text('${snap['Likes'].length}'),
                    SizedBox(
                      width: 40,
                    ),
                  ],
                ),
              ])),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 8),
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                text: snap['Username'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: '  '),
              TextSpan(
                text: snap['Post Name'],
              ),
            ])),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 4),
            child: RichText(
                text: TextSpan(
              text: DateFormat('dd-MM-yyyy , hh:mm a')
                  .format(snap['Date Published'].toDate()),
            )),
          )
        ],
      ),
    );
  }
}
