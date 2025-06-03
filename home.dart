import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var user = FirebaseAuth.instance.currentUser;
  var posts = FirebaseFirestore.instance.collection("posts");
  logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${user!.email}"),
        actions: [IconButton(onPressed: logout, icon: Icon(Icons.login))],
      ),
      body: StreamBuilder(
          stream: posts.snapshots(),
          builder: (context, responce) {
            if (responce.connectionState == ConnectionState.done ||
                responce.connectionState == ConnectionState.active) {
              if (responce.data!.docs.isNotEmpty) {
                return ListView(
                  children: responce.data!.docs
                      .map((item) => ListTile(
                        title: Text(item.get("title")),
                        subtitle: Text(item.get("body")),
                      ))
                      .toList());
              } else {
                return Center(child: Text("NO Data Found"),);
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}