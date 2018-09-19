// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

// TODO: Check if we need to import anything

// TODO: Define any constants

/// Category Route (screen).
///
/// This is the 'home' screen of the Unit Converter. It shows a header and
/// a list of [Categories].
///
/// While it is named CategoryRoute, a more apt name would be CategoryScreen,
/// because it is responsible for the UI at the route's destination.
class CategoryRoute extends StatelessWidget {
  const CategoryRoute();

  static const _categoryNames = <String>[
    'Length',
    'Area',
    'Volume',
    'Mass',
    'Time',
    'Digital Storage',
    'Energy',
    'Currency',
  ];

  static const _baseColors = <Color>[
    Colors.teal,
    Colors.orange,
    Colors.pinkAccent,
    Colors.blueAccent,
    Colors.yellow,
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    // TODO 1) Create a list of the eight Categories, using the names and colors from above. Use a placeholder icon, such as `Icons.cake` for each Category. We'll add custom icons later. ******** Here you're expected to create a list of Category widgets and loop through it to assign a name, color and icon to each Category in the list.

    // TODO 2) Create a list view of the Categories *** Here you're expected to create a list view inside of this Container and then it's children will be the list you made above. You can just put the
    final listView = Container();

    // TODO 3) Create an App Bar ***** Use Control + Spacebar to see the different parameters you can use in an AppBar. Use this to fill out the title, background and elevation. The solution code uses member variables for the values.
    final appBar = AppBar();

    return Scaffold(
      appBar: appBar,
      body: listView,
    );
  }
}
