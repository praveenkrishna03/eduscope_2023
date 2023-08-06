import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(child: Text(user?.email ?? 'user email')),
    );
  }
}
