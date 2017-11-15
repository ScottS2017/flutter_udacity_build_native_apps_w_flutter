import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(new TodoApp());
}

class TodoApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Todo',
      theme: new ThemeData(
        primaryColor: const Color(0xFFb43f54),
        fontFamily: 'Raleway',
      ),
      home: new TodoHome(),
    );
  }
}

class TodoHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new StreamBuilder(
        stream: Firestore.instance
            .collection('tasks')
            .snapshots,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return new Text('Loading...');
          return new CustomScrollView(
            slivers: [
              new SliverAppBar(
                expandedHeight: 200.0,
                flexibleSpace: new FlexibleSpaceBar(
                  title: new Text('todo'),
                  centerTitle: true,
                  background: new Image.asset(
                    'assets/notebook.jpg',
                    color: Theme
                        .of(context)
                        .primaryColor,
                    colorBlendMode: BlendMode.color,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              new SliverList(
                delegate: new SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    if (index >= snapshot.data.documents.length)
                      return null;
                    return new ListTile(
                      title: new Text(snapshot.data.documents[index]['title']),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}