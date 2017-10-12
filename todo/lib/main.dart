import 'package:flutter/material.dart';

void main() {
  runApp(new Todo());
}

class Todo extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Todo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  TodoList({Key key}) : super(key: key);

  @override
  _TodoState createState() => new _TodoState();
}

class _TodoState extends State<TodoList> {
//  var _items = <String>[
//    'Clean the room',
//    'Feed the rabbit',
//    'This is a really long to do item. I guess it can be truncated. Or it does not have to be. Continue typing.',
//    'Mail rent check',
//    'Buy groceries',
//    'Sign up for that pottery class'
//  ];
//

  var _items = <String>[];
  var _listItems = <Widget>[];

  //for (var i in _items) {
//    _listItems.add(new Text(item));
//  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemBuilder: (BuildContext context, int index) => _listItems[index],
      itemCount: _listItems.length,
    );
  }
}
