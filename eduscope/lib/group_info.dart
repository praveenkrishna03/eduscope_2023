//import 'package:chatbot/pages/home_page.dart';
//import 'package:chatbot/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth.dart';
import 'messeging _services.dart';
import 'widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GroupInfo extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String adminName;
  const GroupInfo({Key? key, required this.groupName, required this.groupId, required this.adminName}) : super(key: key);


  @override
  State<GroupInfo> createState() => _GroupInfoState();
}

class _GroupInfoState extends State<GroupInfo> {
  Auth authService = Auth();
  Stream? members;
  String userName='';
  bool _isLoading=false;

  Future<void> initUserData() async {
    String fetchedUserName = await getuserName(uid);
    setState(() {
      userName = fetchedUserName;
    });
  }
  String uid=FirebaseAuth.instance.currentUser!.uid;
  
  getuserName(String uid)async{

     var querySnapshot =  await FirebaseFirestore.instance
    .collection("user")
    .where("User Id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    .get();
    
    var documentSnapshot = querySnapshot.docs[0];
      String userName = documentSnapshot['Name'];

        return userName;
    }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMembers();
    initUserData();
    
  }

  getMembers() async {
    MessagingService(uid: FirebaseAuth.instance.currentUser!.uid).getGroupMembers(widget.groupId).then((val){
      setState(() {
        members = val;
      });
    });
  }
  
  String getName(String r){
    return r.substring(r.indexOf("_")+1);
  }
  String getId(String res){
    return res.substring(0,res.indexOf("_"));
  }

  @override
  Widget build(BuildContext context) {
    String groupName=widget.groupName;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Group Info"),
        actions: [
          IconButton(onPressed: (){
            showDialog(barrierDismissible: false, context: context, builder: (context){
              return AlertDialog(
                title: const Text("Exit"),
                content: const Text("Are you sure you wanna exit from group ☹️"),
                actions: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  },
                    icon: const Icon(Icons.cancel, color: Colors.red,),
                  ),
                  IconButton(onPressed: () async {
                    MessagingService(uid: FirebaseAuth.instance.currentUser!.uid).toggleGroupJoin(widget.groupId, getName(widget.adminName) , widget.groupName,).whenComplete((){
                      //nextScreenReplace(context, const HomePage());
                    });
                  },
                    icon: const Icon(Icons.exit_to_app, color: Colors.green,),
                  ),
                ],
              );
            });
          }, icon: const Icon(Icons.exit_to_app_outlined))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).primaryColor.withOpacity(0.2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Text(widget.groupName.substring(0,1).toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w500,color: Colors.white,),
                  )
                  ),
                  const SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Group: $groupName",style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),),
                      const SizedBox(height: 5,),
                      Text("Admin: ${getName(widget.adminName)}",style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),),
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Add an  existing User',style: TextStyle(fontSize: 15),),
                FloatingActionButton(
                      onPressed: (){
                        popUpDialog(context);
                        
                      },
                      elevation: 0,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: const Icon(Icons.person_add, color: Colors.white, size: 20,),
                    ),
                    
              ],
            ),
            
            memberList(),
          ],
        ),
      ),
    );
  }

   popUpDialog(BuildContext context){
    showDialog(barrierDismissible: false, context: context, builder: (context){
      return StatefulBuilder(
        builder: ((context, setState){
        return AlertDialog(
          title: const Text("Add Group Member",textAlign: TextAlign.left,),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /*_isLoading == true ? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),)
                  : TextField(
                onChanged: (val){
                  setState(() {
                    groupName = val;

                  });
                },
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(15),
                  )
                ),
              ),*/
            ],
          ),
          actions: [
            ElevatedButton(onPressed: (){
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
              child: const Text("CANCEL"),
            ),
            ElevatedButton(onPressed: () async {

              MessagingService(uid: FirebaseAuth.instance.currentUser!.uid).addMemberToGroupAndUser(userName, FirebaseAuth.instance.currentUser!.uid, widget.groupName).whenComplete(() {
                  setState(() {
                    _isLoading = false;
                  });
              });
     
              /*if(groupName != ""){
                setState(() {
                  _isLoading = true;
                });
                 var querySnapshot = await FirebaseFirestore.instance
    .collection("user")
    .where("User Id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    .get();

var documentSnapshot = querySnapshot.docs[0];
userName = documentSnapshot['Name'];

                MessagingService(uid: FirebaseAuth.instance.currentUser!.uid).createGroup(userName, FirebaseAuth.instance.currentUser!.uid, groupName).whenComplete(() {
                  setState(() {
                    _isLoading = false;
                  });
                  Navigator.of(context).pop();
                  showSnakbar(context, Colors.green, "Group created successfully.😍");
                });
              }*/
            },
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              child: const Text("Add"),
            )

          ],
        );
        })
      );
    });
  }
  memberList(){
    return StreamBuilder(
      stream: members,
      builder: (context, AsyncSnapshot snapshot){
        if(snapshot.hasData){
          if(snapshot.data['members'] != null){
            if(snapshot.data['members'].length != 0){
              return ListView.builder(itemCount: snapshot.data['members'].length,
              shrinkWrap: true,
                itemBuilder: (context, index){
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text(getName(snapshot.data['members'][index]).substring(0,1).toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
                      ),
                      title: Text((snapshot.data['members'][index])),
                      subtitle: Text((snapshot.data['members'][index])),
                    ),
                  );
                },
              );
            }
            else{
              return const Center(child: Text("NO MEMBERS"),);
            }
          }
          else{
            return const Center(child: Text("NO MEMBERS"),);
          }
        }
        else{
          return Center(
            child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),
          );
        }
      },
    );
  }
}