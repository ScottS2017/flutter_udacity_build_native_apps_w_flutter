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
        body: new StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('tasks').snapshots,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return new Text('Loading...');
            return new ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return getTaskItem(document);
              }).toList(),
            );
          },
        ),
      ),
    );
  }

  ListTile getTaskItem(DocumentSnapshot document) {
    return new ListTile(
      title: new Text(document['title']),
      leading: document['image'] == null ? null : new Image.network(document['image']),
    );
  }
}
