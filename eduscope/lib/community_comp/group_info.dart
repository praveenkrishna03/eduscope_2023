//import 'package:chatbot/pages/home_page.dart';
//import 'package:chatbot/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduscope_2023/auth.dart';
import 'messeging_services.dart';
import 'package:eduscope_2023/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'add_user.dart';

class GroupInfo extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String adminName;
  const GroupInfo(
      {Key? key,
      required this.groupName,
      required this.groupId,
      required this.adminName})
      : super(key: key);

  @override
  State<GroupInfo> createState() => _GroupInfoState();
}

class _GroupInfoState extends State<GroupInfo> {
  Auth authService = Auth();
  Stream? members;
  String userName = '';
  bool _isLoading = false;

  Future<void> initUserData() async {
    String fetchedUserName = await getuserName(uid);
    setState(() {
      userName = fetchedUserName;
    });
  }

  String uid = FirebaseAuth.instance.currentUser!.uid;

  getuserName(String uid) async {
    var querySnapshot = await FirebaseFirestore.instance
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
    MessagingService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getGroupMembers(widget.groupId)
        .then((val) {
      setState(() {
        members = val;
      });
    });
  }

  String getName(String r) {
    return r.substring(r.indexOf("_") + 1);
  }

  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  @override
  Widget build(BuildContext context) {
    String groupName = widget.groupName;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Group Info"),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Exit"),
                        content: const Text(
                            "Are you sure you wanna exit from group ☹️"),
                        actions: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              MessagingService(
                                      uid: FirebaseAuth
                                          .instance.currentUser!.uid)
                                  .toggleGroupJoin(
                                widget.groupId,
                                getName(widget.adminName),
                                widget.groupName,
                              )
                                  .whenComplete(() {
                                //nextScreenReplace(context, const HomePage());
                              });
                            },
                            icon: const Icon(
                              Icons.exit_to_app,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.exit_to_app_outlined))
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
                      child: Text(
                        widget.groupName.substring(0, 1).toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Group: $groupName",
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Admin: ${getName(widget.adminName)}",
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Add an existing User', style: TextStyle(fontSize: 15)),
                FloatingActionButton(
                  onPressed: () async {
                    // Get the snapshot and groupDocumentReference before calling the popUpDialog
                    var snapshot = await FirebaseFirestore.instance
                        .collection('user')
                        .get();
                    var groupDocumentReference = await FirebaseFirestore
                        .instance
                        .collection('groups')
                        .where('groupId', isEqualTo: widget.groupId)
                        .get();
                    var ref = groupDocumentReference.docs[0];
                    // Call the popUpDialog function
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserListPage(
                            groupId: ref['groupId'],
                            groupName: ref['groupName']),
                      ),
                    );
                  },
                  elevation: 0,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: const Icon(Icons.person_add,
                      color: Colors.white, size: 20),
                ),
              ],
            ),
            memberList(),
          ],
        ),
      ),
    );
  }

  popUpDialog(
      BuildContext context,
      QuerySnapshot<Map<String, dynamic>> snapshot,
      DocumentReference groupDocumentReference,
      groupName) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: ((context, setState) {
            return AlertDialog(
              title: const Text("Add Member", textAlign: TextAlign.left),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ... your existing content, such as the TextField ...

                  // Display a list of users
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.docs.length,
                      itemBuilder: (context, listIndex) {
                        DocumentSnapshot<Map<String, dynamic>> doc =
                            snapshot.docs[listIndex];
                        String userName = doc['Name'];

                        return ListTile(
                          title: Text(userName),
                          onTap: () async {
                            // Call the function to add the selected user to the group
                            await MessagingService().addMemberToGroupAndUser(
                                groupDocumentReference.id, userName, groupName);
                            Navigator.of(context)
                                .pop(); // Close the dialog after adding user
                            showSnakbar(context, Colors.green,
                                "User added to the group.😊");
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: const Text("CANCEL"),
                ),
              ],
            );
          }),
        );
      },
    );
  }

  memberList() {
    return StreamBuilder(
      stream: members,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['members'] != null) {
            if (snapshot.data['members'].length != 0) {
              return ListView.builder(
                itemCount: snapshot.data['members'].length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text(
                          getName(snapshot.data['members'][index])
                              .substring(0, 1)
                              .toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text((snapshot.data['members'][index])),
                      subtitle: Text((snapshot.data['members'][index])),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text("NO MEMBERS"),
              );
            }
          } else {
            return const Center(
              child: Text("NO MEMBERS"),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          );
        }
      },
    );
  }
}
