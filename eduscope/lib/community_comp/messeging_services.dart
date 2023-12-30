import 'package:cloud_firestore/cloud_firestore.dart';

class MessagingService {
  final String? uid;
  MessagingService({this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection("user");
  final CollectionReference groupCollection = FirebaseFirestore.instance.collection("groups");
  final CollectionReference comgroupCollection = FirebaseFirestore.instance.collection("commongroups");

  Future<QuerySnapshot> getUserSnapshot() async {
    return await userCollection.where("User Id", isEqualTo: uid).get();
  }

  Future<QueryDocumentSnapshot<Object?>?> getUserDocumentSnapshot() async {
  final querySnapshot = await getUserSnapshot();
  return querySnapshot.docs.isNotEmpty ? querySnapshot.docs.first : null;
}


Future<void> addMemberToGroupAndUser(String groupId, String userName, String groupName) async {
  try {
    // Update the group's members
    await groupCollection.doc(groupId).update({
      "members": FieldValue.arrayUnion([userName]),
    });

    // Update the user's groups array
    final userDocumentSnapshot = await getUserDocumentSnapshot();
    if (userDocumentSnapshot != null) {
      DocumentReference userDocumentReference = userCollection.doc(userDocumentSnapshot.id);
      await userDocumentReference.update({
        "groups": FieldValue.arrayUnion(["${groupId}_$groupName"]),
      });
    }
  } catch (e) {
    print("Error adding member to group and user: $e");
  }
}


  Future<void> createGroup(String userName, String id, String groupName) async {
    DocumentReference groupDocumentReference = await groupCollection.add({
      "groupName": groupName,      "groupIcon": "",
      "admin": "$userName",
      "members": [],
      "groupId": "",
      "recentMessage": "",
      "recentMessageSender": "",
    });
    await groupDocumentReference.update({
      "members": FieldValue.arrayUnion(["$userName"]),
      "groupId": groupDocumentReference.id,
    });

    final userDocumentSnapshot = await getUserDocumentSnapshot();
    if (userDocumentSnapshot != null) {
      DocumentReference userDocumentReference = userCollection.doc(userDocumentSnapshot.id);
      await userDocumentReference.update({
        "groups": FieldValue.arrayUnion(["${groupDocumentReference.id}"])
      });
    }
  }


  Future<void> createcomGroup(String userName, String id, String groupName) async {
    DocumentReference groupDocumentReference = await comgroupCollection.add({
      "groupName": groupName,      "groupIcon": "",
      "admin": "$userName",
      "members": [],
      "groupId": "",
      "recentMessage": "",
      "recentMessageSender": "",
    });
    await groupDocumentReference.update({
      "members": FieldValue.arrayUnion(["$userName"]),
      "groupId": groupDocumentReference.id,
    });

    final userDocumentSnapshot = await getUserDocumentSnapshot();
    if (userDocumentSnapshot != null) {
      DocumentReference userDocumentReference = userCollection.doc(userDocumentSnapshot.id);
      await userDocumentReference.update({
        "groups": FieldValue.arrayUnion(["${groupDocumentReference.id}"])
      });
    }
  }



  //getting the chats
  getChats(String groupId){
    return groupCollection.doc(groupId).collection("messages").orderBy("time").snapshots();
  }
  Future getGroupAdmin(String groupId) async {
    DocumentReference d = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['admin'];
  }
  //get members
  getGroupMembers(groupId) async {
    return groupCollection.doc(groupId).snapshots();
  }
  // search
  serachByName(String groupName){
    return groupCollection.where("groupName", isEqualTo: groupName).get();
  }
  // return booliean to know present or not
  Future<bool>isUserJoined(String groupName,String groupId, String userName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['groups'];
    if(groups.contains("${groupId}_$groupName")){
      return true;
    }
    else{
      return false;
    }
  }
  // toggling the group join/wait
  Future toggleGroupJoin(String groupId, String userName, String groupName) async {
    //doc
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['groups'];
    //if group has user then remove them or rejoin them
    if(groups.contains("${groupId}_$groupName")){
      await userDocumentReference.update({
        "groups":FieldValue.arrayRemove(["${groupId}"])
      });
      await groupDocumentReference.update({
        "members":FieldValue.arrayRemove(["$userName"])
      });
    }
    else{
      await userDocumentReference.update({
        "groups":FieldValue.arrayUnion(["${groupId}"])
      });
      await groupDocumentReference.update({
        "members":FieldValue.arrayUnion(["$userName"])
      });
    }
  }
  // send message
  sendMessage(String groupId, Map<String, dynamic> chatMessageData) async {
    groupCollection.doc(groupId).collection("messages").add(chatMessageData);
    groupCollection.doc(groupId).update({
      "recentMessage":chatMessageData['message'],
      "recentMessageSender":chatMessageData['sender'],
      "recentMessageTime":chatMessageData['time'].toString(),
    });
  }
}