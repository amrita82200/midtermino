//save here!!
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'dart:collection';

class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}

class BoardPage extends StatefulWidget {
  final Color color;
  BoardPage(this.color);
  BoardPageState createState() => BoardPageState();
}

class BoardPageState extends State<BoardPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  //late User user;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference board = FirebaseFirestore.instance.collection('board1');

  Future<void> addMessage() {
    String message = myController.text;
    return board
        .add({
          'username': auth.currentUser!.email,
          'uid': auth.currentUser!.uid,
          'content': message,
          'createdAt': DateTime.now(),
        })
        .then((value) => print("Message Added"))
        .catchError((error) => print("Failed to add message: $error"));
  }

  final myController = TextEditingController();
  void setFireStore() {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("board1");

    Future<void> getData() async {
      QuerySnapshot querySnapshot = await _collectionRef.get();
      final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      List<dynamic> messages = [allData];
    }
  }

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('board1').snapshots();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("Message Board")),
      body: new Stack(
        children: <Widget>[
          Center(
            child: StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }
                return new ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<dynamic, dynamic>? data = document.data() as Map?;
                    return new ListTile(
                      title: new Text(data!['username']),
                      subtitle: new Text(data['content']),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            //Container(width: 30, height: 30),
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.pink,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.pink,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      controller: myController,
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: addMessage,
                    child: Icon(
                      Icons.send,
                      color: Colors.pink,
                      size: 18,
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
