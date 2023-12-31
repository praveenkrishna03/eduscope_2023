import 'package:flutter/material.dart';

import 'package:eduscope_2023/search_comp/account_search_page.dart';
import 'package:eduscope_2023/search_comp/document_search_page.dart';
import 'package:eduscope_2023/search_comp/media_search_page.dart';
import 'package:eduscope_2023/search_comp/test_search_page.dart';

class SearchPage extends StatefulWidget {
  final uid;
  SearchPage({required this.uid});

  @override
  SearchPage_state createState() => SearchPage_state();
}

class SearchPage_state extends State<SearchPage> {
  var searchName = "";

  int _currentIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    String uid = widget.uid;
    final List<Widget> _search_pages = [
      AccountSearchPage(
        searchName: "",
        uid: uid,
      ),
      MediaSearchPage(searchName: "", uid: uid),
      DocumentSearchPage(
        searchName: "",
        uid: uid,
      ),
      TestSearchPage(),
    ];

    _search_pages[0] = AccountSearchPage(
      searchName: searchName,
      uid: widget.uid,
    );
    return Scaffold(
      appBar: AppBar(
          //backgroundColor: Colors.black,
          title: SizedBox(
        height: 40,
        child: TextField(
          onChanged: (value) {
            setState(() {
              searchName = value;
            });
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              filled: true,
              fillColor: Color.fromARGB(255, 109, 109, 109),
              hintText: 'Search',
              prefixIcon: Icon(Icons.search)),
        ),
      )),
      body: Column(children: [
        BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 94, 95, 95),
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.grey, // Set selected icon color
          unselectedItemColor: Colors.white,
          iconSize: 20,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Accounts', // Text label for the first item
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.video_collection),
              label: 'Media', // Text label for the second item
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.perm_media),
              label: 'Documents', // Text label for the third item
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit_note),
              label: 'Tests', // Text label for the fourth item
            ),
          ],
        ),
        Expanded(
          child: _search_pages[_currentIndex],
        ),
      ]),
    );
  }
}
