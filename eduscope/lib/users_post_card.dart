
import 'package:eduscope_2023/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class UserPostCard extends StatelessWidget{
  FirebaseAuth _auth=FirebaseAuth.instance;
  final snap;
  
  UserPostCard({Key?key,required this. snap}):super(key: key);
  @override

  Widget build(BuildContext context){
    User? user=_auth.currentUser;
       String uid=user?.uid??'';


    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            GestureDetector(
              onTap:(() {
                print(snap['User Id']);
                print(uid);
              Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileViewPage(user_uid: snap['User Id'],imgurl: snap['Profile URL'],),
                            ),
              );
              }
              ),           
            child:Container(
              //color: const Color.fromARGB(255, 126, 126, 126),
              decoration: ShapeDecoration(
                        color: Color.fromARGB(255, 121, 120, 120),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(17),topRight: Radius.circular(17)),
                        ),
                      ),
              
              padding: const EdgeInsets.symmetric(
                vertical: 4,horizontal: 16,
              ).copyWith(right:0),
              
              child: Row(

                children: [
                  CircleAvatar(
                    
                    radius: 16,
                    backgroundImage: NetworkImage(snap['Profile URL']),
                  ),Expanded(
                       
                    child: Padding(padding: const EdgeInsets.only(left: 8),
                    child: Text(snap['Username'])
                    )
                    ),IconButton(onPressed: (){
                            
                    }, icon: Icon(Icons.more_vert))
                ],
              ),
          
            ),
            ),
            SizedBox(height: 5,),
            SizedBox(
              child: Image.network(snap['Post URL'],fit: BoxFit.cover,),
              
            ) ,
            Container(
              decoration: ShapeDecoration(
                        color: Color.fromARGB(255, 121, 120, 120),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(17),bottomRight: Radius.circular(17)),
                        ),
                      ),

            child:Column(
              children:[
            Row(
              children: [
                IconButton(onPressed: (){
                 // likeUpdate();
                  
                }, icon: Icon(Icons.thumb_up)),
                //IconButton(onPressed: (){
                
                //}, icon: Icon(Icons.thumb_down)),
                IconButton(onPressed: (){}, icon: Icon(Icons.share)),
                IconButton(onPressed: (){}, icon: Icon(Icons.drive_file_move)),
                IconButton(onPressed: (){}, icon: Icon(Icons.comment))
              ],
            ),
            Row(
              
              children: [
                
                SizedBox(width: 20,),
                Text('${snap['Likes'].length}'),
                SizedBox(width: 40,),
                
              ],
            ),
              ]
            )
            ),

            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 8),
              child: RichText(text: TextSpan(
                children: [
                  TextSpan(
                text: snap['Username'],
                style: TextStyle(fontWeight: FontWeight.bold),
            ),TextSpan(
                text: snap['Post Name'],

            ),
            
            ])),
              
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(top: 4),
              child: Text('20-08-2023',),
            )
            
            
          ],
        ),
    );
  
  }

  
}