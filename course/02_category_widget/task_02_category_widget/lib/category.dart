// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// To keep your imports tidy, follow the ordering guidelines at
// https://www.dartlang.org/guides/language/effective-dart/style#ordering
import 'package:flutter/material.dart';

/// A custom [Category] widget.
///
/// The widget is composed on an [Icon] and [Text]. Tapping on the widget shows
/// a colored [InkWell] animation.
class Category extends StatelessWidget {
  /// Creates a [Category].
  ///
  /// A [Category] saves the name of the Category (e.g. 'Length'), its color for
  /// the UI, and the icon that represents it (e.g. a ruler).
  // TODO: 2) You'll need to create a constructor that takes the name, color, and iconLocation from main.dart. You technically can use positional parameters or named parameter, but due to the way that Flutter UI code us laid out in the IDE the convention is to use named parameters
  const Category();

  /// Builds a custom widget that shows [Category] information.
  ///
  /// This information includes the icon, name, and color for the [Category].
  @override
  // This `context` parameter describes the location of this widget in the
  // widget tree. It can be used for obtaining Theme data from the nearest
  // Theme ancestor in the tree. Below, we obtain the display1 text theme.
  // See https://docs.flutter.io/flutter/material/Theme-class.html
  Widget build(BuildContext context) {
    // TODO: 3) Build the custom Category widget here, referring to the Specs
    // ******************************* TIPS ***********************************
    // The Specs are at: https://classroom.udacity.com/courses/ud905/lessons/92a39eec-0c04-4d98-b47f-c884b9cd5a3b/concepts/434cfc1b-b9d4-4ff9-a723-38b4e5cfaae4
    // ************ What you're really making here is a button ************
    // 1) In order to use a custom widget as a button you will usually use an InkWell.
    // 2) An InkWell needs something to put it's ink on. It can't just paint nothing, so it paints a Material. Go ahead and start by replacing the below Container() with a Material() and build the rest of your widget within it.
    // 3) The InkWell needs to be a descendant of the Material but it doesn't need to be it's child.
    // 4) For now, just use a lambda to print something when the InkWell is tapped
    // 5) Explore some of the possibilities with Alt+Enter, which makes adding padding very easy. You don't need to highlight your widget to get Alt+Enter to work, just make sure your cursor is somewhere in the constructor's name.
    // 6) Use a Row() to lay out your Category widget and see the layout tutorial at the following link for an in-depth explanation about how to lay things out: https://flutter.io/tutorials/layout/
    // ************************************************************************
    return Container();
  }
}