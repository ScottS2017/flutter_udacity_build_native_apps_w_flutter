// Copyright 2017, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:ui' show lerpDouble;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'constants.dart';
import 'edit.dart';

class TodoHome extends StatefulWidget {
  @override
  TodoHomeState createState() => new TodoHomeState();
}

class TodoHomeState extends State<TodoHome> {
  bool _showDone = false;

  Widget _buildTaskItem(DocumentSnapshot document) {
    return new Container(
      height: todoLineHeight,
      decoration: const BoxDecoration(
        color: TodoColors.background,
        border: const Border(
          bottom: const BorderSide(
            color: TodoColors.disabled,
            width: 0.5,
          ),
        ),
      ),
      child: new Dismissible(
        key: new ValueKey(document.documentID),
        direction: document['done']
            ? DismissDirection.endToStart
            : DismissDirection.horizontal,
        background: _buildBackground(),
        secondaryBackground: _buildSecondaryBackground(),
        onDismissed: (direction) {
          if (direction == DismissDirection.startToEnd) {
            document.reference.updateData({'done': true});
          } else if (direction == DismissDirection.endToStart) {
            document.reference.delete();
          }
        },
        child: new InkWell(
          onTap: () async {
            var result = await Navigator.push(context,
                new MaterialPageRoute(builder: (BuildContext context) {
                  return new TodoEdit(document);
                }));
            if (result != null) {
              document.reference.setData(result, SetOptions.merge);
            }
          },
          child: new Row(
            children: [
              new Expanded(
                child: new ListTile(
                  title: new Text(
                    '${document['title']}',
                    style: document['done'] ? doneStyle : null,
                  ),
                ),
              ),
              new Container(
                height: todoLineHeight,
                width: todoLineHeight,
                child: document['image'] == null
                    ? null
                    : new Image.network(
                  document['image'],
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return new Container(
      color: Colors.lightGreen,
      child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            new Padding(
              padding: new EdgeInsets.only(left: 20.0),
              child: new Icon(Icons.check),
            ),
          ]),
    );
  }

  Widget _buildSecondaryBackground() {
    return new Container(
      color: Colors.red,
      child:
      new Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        new Padding(
          padding: new EdgeInsets.only(right: 20.0),
          child: new Icon(Icons.delete),
        ),
      ]),
    );
  }

  Widget _buildTitle(BuildContext context, BoxConstraints constraints) {
    var fontSize = lerpDouble(
      appBarMinFontSize,
      appBarMaxFontSize,
      (constraints.maxHeight - appBarHeight) / (appBarExpandedHeight - appBarHeight),
    );
    return new Center(
      child: new Text(
        'todo',
        style: new TextStyle(fontSize: fontSize),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var query = Firestore.instance.collection('tasks')
        .where('done', isEqualTo: _showDone);
    return new Scaffold(
      bottomNavigationBar: new Container(
        height: 54.287,
        padding: new EdgeInsets.symmetric(horizontal: 20.0),
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            stops: [0.0, 0.5, 1.0],
            colors: [
              TodoColors.primaryLight,
              TodoColors.primary,
              TodoColors.primaryDark,
            ],
          ),
        ),
        child: new Row(
          children: [
            new Expanded(
              child: new InkWell(
                child: new Text(_showDone ? 'show active' : 'show done'),
                onTap: () {
                  setState(() {
                    _showDone = !_showDone;
                  });
                },
              ),
            ),
            new InkWell(
              onTap: () async {
                var result = await Navigator.push(context,
                    new MaterialPageRoute(builder: (BuildContext context) {
                      return new TodoEdit();
                    }));
                if (result != null) {
                  Firestore.instance
                      .collection('tasks')
                      .reference()
                      .document()
                      .setData(result);
                }
                if (mounted) {
                  setState(() {
                    _showDone = false;
                  });
                }
              },
              child: new Text('+', style: const TextStyle(fontSize: 38.0)),
            ),
          ],
        ),
      ),
      body: new StreamBuilder(
        stream: query.snapshots,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Container();
          }
          return new CustomScrollView(
            slivers: [
              new SliverAppBar(
                pinned: true,
                automaticallyImplyLeading: false,
                expandedHeight:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? appBarExpandedHeight
                    : appBarHeight,
                flexibleSpace: new DecoratedBox(
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                      stops: [0.0, 0.5, 1.0],
                      colors: [
                        TodoColors.primaryDark,
                        TodoColors.primary,
                        TodoColors.primaryLight,
                      ],
                    ),
                  ),
                  child: new Stack(
                    children: [
                      new FlexibleSpaceBar(
                        background: new Image.asset(
                          'assets/notebook.jpg',
                          color:
                          Theme.of(context).primaryColor.withOpacity(0.75),
                          colorBlendMode: BlendMode.overlay,
                          fit: BoxFit.cover,
                        ),
                      ),
                      new Padding(
                        padding: MediaQuery.of(context).padding,
                        child: new LayoutBuilder(
                          builder: _buildTitle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              new SliverList(
                delegate: new SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    if (index >= snapshot.data.documents.length) return null;
                    return _buildTaskItem(snapshot.data.documents[index]);
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
