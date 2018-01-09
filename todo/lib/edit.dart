// Copyright 2017, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'constants.dart';

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
