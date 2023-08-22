import 'dart:async';
import 'dart:ffi';
import 'dart:typed_data';
import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduscope_2023/firebase_api.dart';
import 'package:eduscope_2023/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'post_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'profile_page.dart';



class UploadPage extends StatefulWidget{
  final String uid;
  final String type;
  
  UploadPage({required this.uid,required this.type});

  @override
  UploadPageState createState()=> UploadPageState();
}

class UploadPageState extends State<UploadPage>{
            var hintext_sub='Select subject';
        var hintext_chap='Select Chapter';
        var hintext_class='Select Class';
        bool displaysubjects=false;
  bool displaychapters=false;
  bool displayclass=false;
  
  
        

  final FirebaseStorage _storage=FirebaseStorage.instance;
  
  
    
    FilePickerResult? result;

  String filename='';
  PlatformFile? pickedfile;
  
  bool isLoading=false;
  bool isLoading_2=false;
  File? fileToDisplay;

  
  Uint8List? _file;


    void pickfile_image() async{
    try{
      setState(() {
        isLoading=true;
      });

      result= await FilePicker.platform.pickFiles(type: FileType.image);
      
      if(result!=null){
        
          filename=result!.files.first.name;
          pickedfile=result!.files.first;
  //        pickedfile=result!.files.first;
          fileToDisplay=File(pickedfile!.path.toString());

          print(pickedfile!.name);
          print(pickedfile!.path);
          print(pickedfile!.extension);
          print(pickedfile!.bytes);
      }

      setState(() {
        isLoading=false;
      });

    }
    catch(e){
      print(e);
    }
  }

  void pickfile_video() async{
    try{
      setState(() {
        isLoading=true;
      });

      result= await FilePicker.platform.pickFiles(type: FileType.video);
      
      if(result!=null){
        
          filename=result!.files.first.name;
          pickedfile=result!.files.first;
  //        pickedfile=result!.files.first;
          fileToDisplay=File(pickedfile!.path.toString());

          print(pickedfile!.name);
          print(pickedfile!.path);
          print(pickedfile!.extension);
          print(pickedfile!.bytes);
      }

      setState(() {
        isLoading=false;
      });

    }
    catch(e){
      print(e);
    }
  }

      void pickfile_document() async{
    try{
      setState(() {
        isLoading=true;
      });

      result= await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ['pdf']);
      
      if(result!=null){
        
          filename=result!.files.first.name;
          pickedfile=result!.files.first;
  //        pickedfile=result!.files.first;
          fileToDisplay=File(pickedfile!.path.toString());

          print(pickedfile!.name);
          print(pickedfile!.path);
          print(pickedfile!.extension);
          print(pickedfile!.bytes);
      }

      setState(() {
        isLoading=false;
      });

    }
    catch(e){
      print(e);
    }
  }
      


    @override
    Widget build(BuildContext snapshot) {
  
 
  List<String> subjects=["Tamil","English","Maths","Science","Social Science"];
  List<String> chapter=["1","2","3","4","5","6","7","8","9","10","11","12"];
  List<String> classes=["6","7","8","9","10","11","12"];
     
      


      String uid=widget.uid;
      String destination='$uid-$filename';

      
      return StreamBuilder<QuerySnapshot>(
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


        UploadTask? uploadFile(String destination,File fileToDisplay) {
      String postURL='';
      try{
        setState(() {
          isLoading_2=true;
        });
        
        final ref=FirebaseStorage.instance.ref(destination);
        
        final uploadTask=ref.putFile(fileToDisplay);
       uploadTask.then((TaskSnapshot snapshot) async {
      String postURL = await snapshot.ref.getDownloadURL();
      PostModel post =PostModel(
        username:'$name',
        postname:filename,
        posturl:postURL,
        uid:widget.uid,
        datepublished:DateTime.now(),
        profileURL:'$Profile_URL',
        type:widget.type,
        likes:0,
        dislikes:0,);

        PostModel post_doc =PostModel(
        username:'$name',
        postname:filename,
        posturl:'https://firebasestorage.googleapis.com/v0/b/eduscope-7f35b.appspot.com/o/document.jpg?alt=media&token=bfb68b93-6629-417b-83e0-1e66ee5da997',
        uid:widget.uid,
        datepublished:DateTime.now(),
        profileURL:'$Profile_URL',
        type:widget.type,
        likes:0,
        dislikes:0,);

      

        if(widget.type=='image'){
        CollectionReference userdata= FirebaseFirestore.instance.collection('posts');
      userdata.add(post.toJson());
        }
        else if(widget.type=='document'){
          CollectionReference userdata= FirebaseFirestore.instance.collection('posts');
      userdata.add(post_doc.toJson());
        }
        else if(widget.type=='video'){
          CollectionReference userdata= FirebaseFirestore.instance.collection('reels');
      userdata.add(post.toJson());
        }


      setState(() {
        isLoading_2 = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File uploaded successfully')),
      );
      Navigator.pop(context);
    });
        print(postURL);
        
        
        
         
         
         
         

        
    }catch(e){
      print(e);
    }

      
/*cuser.get().then((querySnapshot) {
  if (querySnapshot.size > 0) {
    final documentSnapshot = querySnapshot.docs[0];
    final documentReference = documentSnapshot.reference;

    documentReference.update({
      'Post URL': fileURL, // Replace with the actual URL you want to add
    });
  }
});*/
      
      }
      TextEditingController controller=TextEditingController();
      

        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
       leading:
            IconButton(onPressed: () {
                Navigator.pop(context);
            }, icon: const Icon(Icons.arrow_back)),
        actions: [
          IconButton(
              onPressed: ()  {
                
              },
              icon: const Icon(Icons.logout))
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
                  body: SingleChildScrollView(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                          SizedBox(height: 20,),

                          if(pickedfile==null)
                          Center(child:isLoading?
                          CircularProgressIndicator() :TextButton(
                            style:ButtonStyle(
                              backgroundColor:MaterialStateProperty.all<Color>(Colors.grey),
                          
                            ),
                            onPressed:(){
                              if(widget.type=='image'){
                                  pickfile_image();
                              }
                              else if(widget.type=='video'){
                                 pickfile_video();
                              }
                              else if(widget.type=='document'){
                                 pickfile_document();
                              }
                              

                             
                          },
                          child:const Text(
                            'Select File',
                            style: TextStyle(
                                  color: Color(0xFF000000),
                                  
                                ),),
                          ),
                          )
                          ,
                          if(pickedfile!=null)Column(
                            children:[
                              SizedBox(height: 10,),
                              SizedBox(
                              child: Image.file(File(pickedfile!.path!),fit: BoxFit.cover,),),
                              SizedBox(height: 10,),
                              SizedBox(height: 50,child:Text('$filename')),
                              SizedBox(height: 10,),

                                SizedBox(height: 10,),
                              Container(
                      
                      height: 50,
                      decoration: ShapeDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                              child: TextField(
                                textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(
                              255, 24, 24, 24), // Set the input text color here
                        ),
                        cursorColor: Colors.black,
                        controller: controller,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 109, 109, 109)),
                          hintText: 'Enter postname and description here......',
                        ),
                              ),),
                              SizedBox(height: 10,),
                               Container(
                              height: 40,
                              width: 200,
                              //color: Colors.black,
                              decoration: ShapeDecoration(
                        color: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                      ),

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                
    //controller: controller,
    //decoration: InputDecoration(
                              children: [
                              Text('$hintext_class',),
                            
                              GestureDetector(
                                
                                onTap: () {
                                  setState(() {
                                    displayclass = !displayclass;
                                  });
                                },
                                child: Icon(Icons.arrow_drop_down,),
                                
                              ),
                              ]
                            //),
                          ),
                          ),
                          displayclass
                              ? Container(
                                  height: 200,
                                  width: 230,
                                  child: ListView.builder(
                                    itemCount: classes.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            //controller.text = subjects[index];
                                            hintext_chap=classes[index];
                                            displayclass= false;
                                            //print(controller.text);
                                          });
                                        },
                                        child: ListTile(

                                          title: Text(classes[index]),
                                        ),
                                      );
                                    },
                                  ),
                                ): SizedBox(),
                              SizedBox(height: 10,),
                              Container(
                                  height: 40,
                                  width: 200,
                              //color: Colors.black,
                              decoration: ShapeDecoration(
                               color: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                      ),

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                
                          //controller: controller,
                          //decoration: InputDecoration(
                          children: [
                          Text('$hintext_sub',),
                        
                          GestureDetector(
                            
                            onTap: () {
                              setState(() {
                                displaysubjects = !displaysubjects;
                              });
                            },
                            child: Icon(Icons.arrow_drop_down,),
                            
                          ),
                          ]
                        //),
                      ),
                      ),
                      displaysubjects
                          ? Container(
                              height: 200,
                              width: 230,
                              child: ListView.builder(
                                itemCount: subjects.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        //controller.text = subjects[index];
                                        hintext_sub=subjects[index];
                                        displaysubjects = false;
                                        //print(controller.text);
                                      });
                                    },
                                    child: ListTile(

                                      title: Text(subjects[index]),
                                    ),
                                  );
                                },
                              ),
                            ): SizedBox(),

                            SizedBox(height: 10,),
                            Container(
                              height: 40,
                              width: 200,
                              //color: Colors.black,
                              decoration: ShapeDecoration(
                        color: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                      ),

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                
    //controller: controller,
    //decoration: InputDecoration(
                              children: [
                              Text('$hintext_chap',),
                            
                              GestureDetector(
                                
                                onTap: () {
                                  setState(() {
                                    displaychapters = !displaychapters;
                                  });
                                },
                                child: Icon(Icons.arrow_drop_down,),
                                
                              ),
                              ]
                            //),
                          ),
                          ),
                          displaychapters
                              ? Container(
                                  height: 200,
                                  width: 230,
                                  child: ListView.builder(
                                    itemCount: chapter.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            //controller.text = subjects[index];
                                            hintext_chap=chapter[index];
                                            displaychapters= false;
                                            //print(controller.text);
                                          });
                                        },
                                        child: ListTile(

                                          title: Text(chapter[index]),
                                        ),
                                      );
                                    },
                                  ),
                                ): SizedBox(),
                                SizedBox(height: 10,),
    


                              SizedBox(
                              child:isLoading_2?CircularProgressIndicator():TextButton(
                                style:ButtonStyle(
                              backgroundColor:MaterialStateProperty.all<Color>(Colors.grey),
                          
                            ),
                                onPressed: () {
                                  
                                  uploadFile(destination, fileToDisplay!);
                                  
                                  
                                  
                                  
                                },
                                child: Text('Upload',style: TextStyle(
                                  color: Color(0xFF000000),
                                  
                                ),),
                                
                              )

                              )
                      ]),
                          
                    ])));
                
          
            
           
  }
  
      );

}
}