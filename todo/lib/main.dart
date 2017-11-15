import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(new Todo());
}

class Todo extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Todo',
      home:  new Scaffold(
        appBar: new AppBar(
          title: new Text("ToDo")
        ),
        body: new StreamBuilder(
          stream: Firestore.instance.collection('tasks').snapshots,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return new Text('Loading...');
            return new ListView(
              children: snapshot.data.documents.map((document) {
                return new ListTile(
                  title: new Text(document['title']),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
