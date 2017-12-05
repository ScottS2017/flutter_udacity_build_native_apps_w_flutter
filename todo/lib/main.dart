import 'dart:ui' show lerpDouble;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

void main() {
  runApp(new TodoApp());
}

const todoLineHeight = 63.0;
const appBarHeight = 63.213;
const appBarExpandedHeight = 212.054;
const appBarMinFontSize = 27.81;
const appBarMaxFontSize = 40.48;
const doneStyle = const TextStyle(
  color: TodoColors.done,
  decoration: TextDecoration.lineThrough,
);

class TodoColors {
  static const Color primaryDark = const Color(0xFF863352);
  static const Color primary = const Color(0xFFB43F54);
  static const Color primaryLight = const Color(0xFFCA4855);
  static const Color background = const Color(0xFF1C1E27);
  static const Color done = const Color(0xFFBABCBE);
  static const Color accent = const Color(0xFF42B2CC);
  static const Color disabled = const Color(0xFFBABCBE);
  static const Color line = const Color(0xFF414044);
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Todo',
      theme: new ThemeData(
        primaryColor: TodoColors.primary,
        canvasColor: TodoColors.background,
        fontFamily: 'Raleway',
        brightness: Brightness.dark,
      ),
      home: new TodoHome(),
    );
  }
}

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
    var expansion = constraints.maxHeight - appBarHeight;
    var t = expansion / (appBarExpandedHeight - appBarHeight);
    var fontSize =
        lerpDouble(appBarMinFontSize, appBarMaxFontSize, t);
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

class TodoEdit extends StatefulWidget {
  TodoEdit([this.document]);

  /// If we are editing, the DocumentSnapshot we are editing.
  ///
  /// `null` for a new item.
  final DocumentSnapshot document;

  @override
  TodoEditState createState() => new TodoEditState();
}

class TodoEditState extends State<TodoEdit> {
  TextEditingController _controller;
  String _taskImage;

  @override
  void initState() {
    String text = widget.document == null ? null : widget.document['title'];
    _controller = new TextEditingController(text: text);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('todo'),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(10.0),
        child: new Column(
          children: [
            new Expanded(
              child: new TextField(
                controller: _controller,
                decoration: new InputDecoration(
                  hintText: 'Type something...',
                ),
              ),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                new FlatButton(
                  color: TodoColors.accent,
                  onPressed: () async {
                    var _file = await ImagePicker.pickImage();
                    print(_file.path);
                    _taskImage = _file.path;
                  },
                  child: new Icon(Icons.photo_camera),
                ),
                new Container(width: 5.0),
                new FlatButton(
                  color: TodoColors.accent,
                  onPressed: () async {
                    Map<String, dynamic> result = {
                      'title': _controller.text,
                    };
                    if (widget.document == null) {
                      result['done'] = false;
                    }
                    if (_controller.text.trim().length > 0) {
                      if (_taskImage != null) {
                        File taskImageFile = await new File(_taskImage);
                        final StorageReference storageRef = FirebaseStorage
                            .instance
                            .ref()
                            .child(new DateTime.now()
                                .millisecondsSinceEpoch
                                .toString())
                            .child(_taskImage.split('/').last);
                        UploadTaskSnapshot uploadTaskSnapshot =
                            await storageRef.put(taskImageFile).future;
                        result['image'] =
                            uploadTaskSnapshot.downloadUrl.toString();
                      }
                      Navigator.pop(context, result);
                    }
                  },
                  child: new Text('done'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
