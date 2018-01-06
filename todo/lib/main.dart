// Copyright 2017, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'constants.dart';
import 'home.dart';

void main() {
  runApp(new TodoApp());
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

