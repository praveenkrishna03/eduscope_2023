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
      
 


     UploadTask? uploadFile(String destination,File fileToDisplay) {
      String postURL='';
      try{
        setState(() {
          isLoading_2=true;
        });
        
        final ref=FirebaseStorage.instance.ref(destination);
        
        final uploadTask=ref.putFile(fileToDisplay);
       uploadTask.then((TaskSnapshot snapshot) async {
      String downloadURL = await snapshot.ref.getDownloadURL();
      PostModel post =PostModel(
        username:'',
        postname:filename,
        posturl:postURL,
        uid:widget.uid,
        datepublished:DateTime.now(),
        profileURL:'',
        type:widget.type,
        likes:0,);

        CollectionReference userdata= FirebaseFirestore.instance.collection('posts');
      userdata.add(post.toJson());

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

    

    @override
    Widget build(BuildContext context) {


      String uid=widget.uid;
      String destination='$uid-$filename';
        


        return Scaffold(
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
                          ),
                          if(pickedfile!=null)Column(
                            children:[
                              SizedBox(height: 10,),
                              //SizedBox(height: 300,width: 300,),
                              SizedBox(height: 10,),
                              SizedBox(height: 50,child:Text('$filename')),
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
}