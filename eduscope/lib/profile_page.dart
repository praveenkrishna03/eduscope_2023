import 'dart:ffi';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduscope_2023/settings_home.dart';
import 'package:eduscope_2023/util.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'settings_home.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ProfilePage extends StatefulWidget {
  final String uid;
  
  ProfilePage({required this.uid});

  @override
  ProfilePage_state createState() => ProfilePage_state();
}

class ProfilePage_state extends State<ProfilePage> {
  
  final FirebaseStorage _storage=FirebaseStorage.instance;
  
  String _imgurl='';
  Uint8List? _image;
  void selectImage() async{
    String uid=widget.uid;
    Uint8List img= await pickImage(ImageSource.gallery);
    
    
    String imgurl=await uploadImageToStorage('$uid',img);
    setState(() {
     _image= img; 
     _imgurl=imgurl;
    });
    print(_imgurl);
     final cuser = FirebaseFirestore.instance.collection('user').where('User Id', isEqualTo:widget.uid);

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

  Future<String> uploadImageToStorage(String childName ,Uint8List file)async{
    Reference ref =_storage.ref().child(childName);
    UploadTask uploadTask=ref.putData(file);
    TaskSnapshot snapshot=await uploadTask;
    String profile=await snapshot.ref.getDownloadURL();
    return profile;
  }
  
  
  @override
  
  Widget build(BuildContext context) {
    String uid=widget.uid;
      


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
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                              builder: (context) => SettingsHomePage(uid:uid),
                            ),);
                },
                icon: Icon(
                  Icons.settings,
                  size: 25,
                ),
              ),
              
            ),
            Positioned(
              top: 30,
              left: 120,
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
                  SizedBox(height: 10,),
                  Positioned(
                    
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
              left: 100,
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
           
        
            
            
              
            
            
           /* Positioned(
              top: 100,
              left: 120,
              child: Text('0',
              style:TextStyle(
                fontSize: 16
              )),
            ),
            Positioned(
              top: 100,
              left: 180,
              child: Text('0',
              style:TextStyle(
                fontSize: 16
              )),
            ),
            Positioned(
              top: 100,
              left: 265,
              child: Text('0',
              style:TextStyle(
                fontSize: 16
              )),
            ),*/
            
            
              
          
            
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

         
          //String Name = document['Name'] as String? ?? 'No Name';
          //String Email = document['Email']as String? ?? 'No Email';
//String Name=document['Name']?? 'NULL';
          
      
        
        
          },
      )
          
    );
    
  }
}


/*import 'package:flutter/material.dart';

void main() {
  runApp(const FigmaToCodeApp());
}

// Generated by: https://www.figma.com/community/plugin/842128343887142055/
class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(children: [
          Account1(),
        ]),
      ),
    );
  }
}

class Account1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 360,
          height: 800,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 360,
                  height: 800,
                  decoration: ShapeDecoration(
                    color: Colors.white.withOpacity(0.8500000238418579),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(38),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: -1,
                top: 0,
                child: Container(
                  width: 360,
                  height: 800,
                  decoration: BoxDecoration(color: Color(0xFF292828)),
                ),
              ),
              Positioned(
                left: 0,
                top: 70,
                child: Container(
                  width: 360,
                  height: 235,
                  decoration: BoxDecoration(color: Color(0xFF292929)),
                ),
              ),
              Positioned(
                left: 173,
                top: 171,
                child: SizedBox(
                  width: 16,
                  height: 7,
                  child: Text(
                    '0',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontFamily: 'Inder',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 97,
                top: 171,
                child: SizedBox(
                  width: 16,
                  height: 7,
                  child: Text(
                    '0',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontFamily: 'Inder',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 214,
                child: Container(
                  width: 360,
                  height: 586,
                  decoration: ShapeDecoration(
                    color: Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 741,
                child: Container(
                  width: 360,
                  height: 59,
                  decoration: ShapeDecoration(
                    color: Color(0xFF292929),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 15,
                top: 744,
                child: Container(
                  width: 50,
                  height: 50,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: ShapeDecoration(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 0.50, color: Color(0xFF887F7F)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 294,
                top: 745,
                child: Container(
                  width: 50,
                  height: 50,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 225,
                top: 745,
                child: Container(
                  width: 50,
                  height: 50,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 80,
                top: 745,
                child: Container(
                  width: 50,
                  height: 50,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 122,
                top: -17,
                child: Container(
                  width: 116,
                  height: 108,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/116x108"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 5,
                top: 96,
                child: Container(
                  width: 70,
                  height: 70,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 21,
                top: 223,
                child: Container(
                  width: 30,
                  height: 30,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 89,
                top: 102,
                child: SizedBox(
                  width: 148,
                  height: 35,
                  child: Text(
                    'your username',
                    style: TextStyle(
                      color: Color(0xFFFFFBFB),
                      fontSize: 13,
                      fontFamily: 'Inknut Antiqua',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 90,
                top: 121,
                child: SizedBox(
                  width: 148,
                  height: 35,
                  child: Text(
                    'class',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontFamily: 'Inknut Antiqua',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 90,
                top: 133,
                child: SizedBox(
                  width: 148,
                  height: 35,
                  child: Text(
                    'institute',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontFamily: 'Inknut Antiqua',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 180,
                top: 214,
                child: Container(
                  width: 180,
                  height: 49,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(side: BorderSide(width: 0.50)),
                  ),
                ),
              ),
              Positioned(
                left: 58,
                top: 226,
                child: SizedBox(
                  width: 93,
                  height: 35,
                  child: Text(
                    'Shared by you',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'Inknut Antiqua',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 228,
                top: 226,
                child: SizedBox(
                  width: 93,
                  height: 35,
                  child: Text(
                    'Saved files',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'Inknut Antiqua',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 198,
                top: 226,
                child: Container(
                  width: 24,
                  height: 24,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 285,
                top: 116,
                child: Container(
                  width: 30,
                  height: 30,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 130,
                top: 268,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/100x100"),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(side: BorderSide(width: 0.50)),
                  ),
                ),
              ),
              Positioned(
                left: 12,
                top: 380,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/100x100"),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(side: BorderSide(width: 0.50)),
                  ),
                ),
              ),
              Positioned(
                left: 248,
                top: 380,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/100x100"),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(side: BorderSide(width: 0.50)),
                  ),
                ),
              ),
              Positioned(
                left: 12,
                top: 268,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/100x100"),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(side: BorderSide(width: 0.50)),
                  ),
                ),
              ),
              Positioned(
                left: 248,
                top: 268,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/100x100"),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(side: BorderSide(width: 0.50)),
                  ),
                ),
              ),
              Positioned(
                left: 130,
                top: 380,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/100x100"),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(side: BorderSide(width: 0.50)),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 155,
                top: 745,
                child: Container(
                  width: 50,
                  height: 50,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 160,
                top: 690,
                child: Container(
                  width: 41,
                  height: 40,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 155,
                top: 685,
                child: Container(
                  width: 50,
                  height: 50,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: ShapeDecoration(
                            color: Color(0xFFD9D9D9),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 89,
                top: 178,
                child: SizedBox(
                  width: 51,
                  height: 18,
                  child: Text(
                    'Post',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontFamily: 'Inknut Antiqua',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 146,
                top: 178,
                child: SizedBox(
                  width: 68,
                  height: 18,
                  child: Text(
                    'Followers',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontFamily: 'Inknut Antiqua',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 231,
                top: 178,
                child: SizedBox(
                  width: 84,
                  height: 13,
                  child: Text(
                    'Following',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontFamily: 'Inknut Antiqua',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 257,
                top: 171,
                child: SizedBox(
                  width: 16,
                  height: 10,
                  child: Text(
                    '0',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontFamily: 'Inder',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
*/