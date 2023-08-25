import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduscope_2023/messeging%20_services.dart';
import 'package:eduscope_2023/search_community.dart';
import 'package:eduscope_2023/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'group_tile.dart';
import 'auth.dart';
import 'account_search_page.dart';
import 'auth.dart';


class CommunityPage extends StatefulWidget {
  @override
  CommunityPage_state createState() => CommunityPage_state();
}

class CommunityPage_state extends State<CommunityPage> {
  Stream<QuerySnapshot<Map<String, dynamic>>>? groups = FirebaseFirestore.instance.collection('groups').snapshots();

   bool _isLoading = false;
  String groupName = "";
   String userName = "";
  String email ="";
  Auth authService = Auth();
  
  Future<void> initUserData() async {
    String fetchedUserName = await getuserName(uid);
    setState(() {
      userName = fetchedUserName;
    });
  }
 

    @override
void initState() {
  super.initState();
  // Initialize the groups stream here
  
  groups = FirebaseFirestore.instance.collection('groups').snapshots();
  initUserData();
}

   

  @override
  Widget build(BuildContext context) {
    
  
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Eduscope Community'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Common Groups',
                icon: Icon(Icons.diversity_2),
                
              ),
              Tab(
                text: 'Personal Groups',
                icon: Icon(Icons.group),
              ),
              
            ],
          ),
        ),
        body: TabBarView(
          
          children: <Widget>[
            Center(
              child:Column(
                children: [
                     Flexible(
                      
                    child: commongroupList(userName),
                  ),
                  
                   
                ],
                )
              
            
              
            ),
            Center(
              child:Column(
                children: [
                     Flexible(
                      
                    child: groupList(userName),
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    FloatingActionButton(
                      onPressed: (){
                        popUpDialog(context);
                      },
                      elevation: 0,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: const Icon(Icons.add, color: Colors.white, size: 30,),
                    ),
                    
                  ],)
                    
                ],
                )
              
            
              
            ),
            
          ],
          
        ),
        
      ),
    );
    

  }
   /*String getId(String res){
  int underscoreIndex = res.indexOf('_');
  print(underscoreIndex);
  
    return res.substring(0, underscoreIndex);
  
  
}*/

String getName(String res){
  int underscoreIndex = res.indexOf('_');
     print(underscoreIndex);
     return res.substring(underscoreIndex + 1);
     
   
   // Return an appropriate default value if underscore is not found
}

  getuserName(String uid)async{

     var querySnapshot =  await FirebaseFirestore.instance
    .collection("user")
    .where("User Id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    .get();
    
    var documentSnapshot = querySnapshot.docs[0];
      String userName = documentSnapshot['Name'];

        return userName;
    }



  popUpDialog(BuildContext context){
    showDialog(barrierDismissible: false, context: context, builder: (context){
      return StatefulBuilder(
        builder: ((context, setState){
        return AlertDialog(
          title: const Text("Create a group",textAlign: TextAlign.left,),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _isLoading == true ? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),)
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
              ),
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
              if(groupName != ""){
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
              }
            },
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              child: const Text("CREATE"),
            )

          ],
        );
        })
      );
    });
  }
 String uid=FirebaseAuth.instance.currentUser!.uid;
  
    commongroupList(String userName) {
  return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
    
    stream: FirebaseFirestore.instance.collection('commongroups').snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        return noGroupWidget();
      } else {
        print("Number of documents: ${snapshot.data!.docs.length}");

        print("Data available: ${snapshot.data!.docs.length} documents");
        return Container(
  height: MediaQuery.of(context).size.height * 0.6,
  child: ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: snapshot.data!.docs.length,
    itemBuilder: (context, listIndex) {
      DocumentSnapshot<Map<String, dynamic>> doc = snapshot.data!.docs[listIndex];
      
      String groupName = doc['groupName'];
      String groupId = doc['groupId'];
      var querySnapshot =  FirebaseFirestore.instance
    .collection("user")
    .where("User Id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    .get();


      
      print("Group Name: $groupName");
      print("Group ID: $groupId");

      //var documentSnapshot = querySnapshot.docs[0];
      //String userName = documentSnapshot['Name'];


       print('User Name:$userName');
      return GroupTile(
        groupName: groupName,
        groupId: groupId,
        userName: userName,
      );
    },
  ),
);

      }
    },
  );
}

   groupList(String userName) {
  return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
    
    stream: FirebaseFirestore.instance.collection('groups').where('members',arrayContains: userName).snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        return noGroupWidget();
      } else {
        print("Number of documents: ${snapshot.data!.docs.length}");

        print("Data available: ${snapshot.data!.docs.length} documents");
        return Container(
  height: MediaQuery.of(context).size.height * 0.6,
  child: ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: snapshot.data!.docs.length,
    itemBuilder: (context, listIndex) {
      DocumentSnapshot<Map<String, dynamic>> doc = snapshot.data!.docs[listIndex];
      
      String groupName = doc['groupName'];
      String groupId = doc['groupId'];
      var querySnapshot =  FirebaseFirestore.instance
    .collection("user")
    .where("User Id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    .get();


      
      print("Group Name: $groupName");
      print("Group ID: $groupId");

      //var documentSnapshot = querySnapshot.docs[0];
      //String userName = documentSnapshot['Name'];


       print('User Name:$userName');
      return GroupTile(
        groupName: groupName,
        groupId: groupId,
        userName: userName,
      );
    },
  ),
);

      }
    },
  );
}



  noGroupWidget(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (){
              popUpDialog(context);
            },
              child: Icon(Icons.add_circle, color: Colors.grey[700], size: 75,)),
          const SizedBox(height: 20,),
          const Text("You've not joined any gruops, tap on the add icon to create a group otherwise search from top search button"
          , textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
