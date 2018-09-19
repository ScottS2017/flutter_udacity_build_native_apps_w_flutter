// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// You can read about packages here: https://flutter.io/using-packages/

// TODO 4) Create an import for the CategoryRoute widget
import 'package:flutter/material.dart';

/// The function that is called when main.dart is run.
void main() {
  runApp(UnitConverterApp());
}

/// This widget is the root of our application.
///
/// The first screen we see is a list [Categories].
class UnitConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unit Converter',
      // TODO 5) Instead of pointing to exactly 1 Category widget, our home should now point to an instance of the CategoryRoute widget. ******** You're supposed to take out this Container and replace it with the Category route. Don't forget to fill out your parameters, title, color and elevation.
      home: Container(),
    );
  }
}
