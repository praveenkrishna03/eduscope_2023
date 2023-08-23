import 'package:flutter/material.dart';
import 'group_tile.dart';


class CommunityPage extends StatefulWidget {
  @override
  CommunityPage_state createState() => CommunityPage_state();
}

class CommunityPage_state extends State<CommunityPage> {
  Stream? groups;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
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
        body: const TabBarView(
          children: <Widget>[
            Center(
              child: Text("Common Groups"),
            ),
            Center(
              child: Text('Personal Groups'),
            ),
            
          ],
        ),
      ),
    );
    

  }
    String getName(String res){
    return res.substring(res.indexOf("_")+1);
  }
  
  String getId(String res){
    return res.substring(0,res.indexOf("_"));
  }
    groupList(){
    return StreamBuilder(stream: groups,
    builder: (context, AsyncSnapshot snapshot){
      // make some check
      if(snapshot.hasData){
        if(snapshot.data['groups'] != null){
          if(snapshot.data['groups'].length != 0){
            return ListView.builder(
              itemCount: snapshot.data['groups'].length,
              itemBuilder: (context,index){
                int reveseIndex = snapshot.data['groups'].length - index - 1;
                return GroupTile(
                    groupName: getName(snapshot.data['groups'][reveseIndex]), groupId: getId(snapshot.data['groups'][reveseIndex]), userName: snapshot.data['fullName']);
              },
            );
          }else{
            return noGroupWidget();
          }
        }
        else{
          return noGroupWidget();
        }
      }
      else{
        return Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,

          ),
        );}
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
              //popUpDialog(context);
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
