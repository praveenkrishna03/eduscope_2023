// user_list_page.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'messeging_services.dart';

class UserListPage extends StatelessWidget {
  final String groupId;
  final String groupName;

  UserListPage({required this.groupId, required this.groupName});

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User List"),
      ),
      body: UserListView(groupId: groupId, groupName: groupName),
    );
  }
}

class UserListView extends StatelessWidget {
  final String groupId;
  final String groupName;

  UserListView({required this.groupId, required this.groupName});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('user').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot<Map<String, dynamic>> doc =
                  snapshot.data!.docs[index];
              String userName = doc['Name'];
              String userEmail = doc['Email'];

              return ListTile(
                title: Text(userName),
                subtitle: Text(userEmail),
                onTap: () async {
                  // Call the function to add the selected user to the group
                  await MessagingService()
                      .addMemberToGroupAndUser(groupId, userName, groupName);

                  // Navigate back to the community page
                  Navigator.of(context).pop();
                },
              );
            },
          );
        }
      },
    );
  }
}
