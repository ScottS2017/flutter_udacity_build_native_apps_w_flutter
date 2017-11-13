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
  final _items = <String>[
    'Clean the room',
    'Feed the rabbit',
    'This is a really long to do item. I guess it can be truncated. Or it does not have to be. Continue typing.',
    'Mail rent check',
    'Buy groceries',
    'Sign up for that pottery class',
    'Clean the room',
    'Feed the rabbit',
    'This is a really long to do item. I guess it can be truncated. Or it does not have to be. Continue typing.',
    'Mail rent check',
    'Buy groceries',
    'Sign up for that pottery class',
    'Clean the room',
    'Feed the rabbit',
    'This is a really long to do item. I guess it can be truncated. Or it does not have to be. Continue typing.',
    'Mail rent check',
    'Buy groceries',
    'Sign up for that pottery class',
    'Clean the room',
    'Feed the rabbit',
    'This is a really long to do item. I guess it can be truncated. Or it does not have to be. Continue typing.',
    'Mail rent check',
    'Buy groceries',
    'Sign up for that pottery class',
  ];
  final _done = <String>[
    'Mow the lawn',
    'Bake some croissants',
    'Clean the room',
    'Feed the rabbit',
    'This is a really long to do item. I guess it can be truncated. Or it does not have to be. Continue typing.',
    'Mail rent check',
    'Buy groceries',
    'Sign up for that pottery class',
    'Clean the room',
    'Feed the rabbit',
    'This is a really long to do item. I guess it can be truncated. Or it does not have to be. Continue typing.',
    'Mail rent check',
    'Buy groceries',
    'Sign up for that pottery class',
  ];
  var _currentPage;
  var _todoPage;
  var _donePage;
  bool _userIsTyping = false;

  void _chooseList(int value) {
    switch (value) {
      case 0:
        if (_currentPage != _todoPage) {
          setState(() {
            _currentPage = _todoPage;
          });
        }
        break;
      case 1:
        if (_currentPage != _donePage) {
          setState(() {
            _currentPage = _donePage;
          });
        }
        break;
    }
  }

  void _showSaveOptions(String value) {
    setState(() {
      if (value.length > 0) {
        _userIsTyping = true;
      } else {
        _userIsTyping = false;
      }
    });
  }

  void _buildItems() {
    var _todoItems = <Widget>[];
    var _doneItems = <Widget>[];
    _todoItems.add(new Container(
      color: Colors.amber[100],
      padding: const EdgeInsets.all(16.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Flexible(
            fit: FlexFit.loose,
            child: new Container(
              alignment: FractionalOffset.topLeft,
              child: new TextField(
                style: new TextStyle(
                  color: Colors.red,
                  fontSize: 30.0,
                ),
                decoration: new InputDecoration(
                  hintText: 'Add a note',
                  hideDivider: true,
                  hintStyle: new TextStyle(
                    color: Colors.grey,
                    fontSize: 28.0, // Throws an error if you don't specify
                  ),
                ),
                maxLines: null,
                // TODO(maryx) this should be set to null pending bug fix in flutter
                // https://github.com/flutter/flutter/issues/12046
                keyboardType: TextInputType.multiline,
                onChanged: (value) => _showSaveOptions(value),
              ),
            ),
          ),
          new Row(
            children: <Widget>[
              new Icon(
                Icons.attach_file,
                size: 50.0,
              ),
              new Offstage(
                offstage: _userIsTyping,
                child: new Icon(
                  Icons.check,
                  size: 50.0,
                ),
              ),
            ],
          ),
        ],
      ),
    ));

    for (var i in _items) {
      _todoItems.add(new Container(
        color: Colors.green[50],
        margin: const EdgeInsets.only(
          left: 8.0,
          right: 8.0,
          top: 8.0,
        ),
        padding: const EdgeInsets.all(16.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Flexible(
              fit: FlexFit.loose,
              child: new Container(
                child: new Text(
                  i,
                  softWrap: true,
                  style: new TextStyle(
                    color: Colors.grey[800],
                    fontSize: 30.0,
                  ),
                ),
              ),
            ),
            new Row(
              children: <Widget>[
                new Icon(Icons.check),
                new Icon(Icons.edit),
                new Icon(Icons.delete_forever),
              ],
            ),
          ],
        ),
      ));
    }

    for (var i in _done) {
      _doneItems.add(new Container(
        color: Colors.grey[100],
        margin: const EdgeInsets.only(
          left: 8.0,
          right: 8.0,
          top: 8.0,
        ),
        padding: const EdgeInsets.all(16.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Flexible(
              fit: FlexFit.loose,
              child: new Container(
                child: new Text(
                  i,
                  softWrap: true,
                  style: new TextStyle(
                    color: Colors.grey[500],
                    fontSize: 30.0,
                  ),
                ),
              ),
            ),
            new Row(
              children: <Widget>[
                new Icon(Icons.undo),
                new Icon(Icons.delete_forever),
              ],
            ),
          ],
        ),
      ));
    }

    setState(() {
      _todoPage = new ListView.builder(
        itemBuilder: (BuildContext context, int index) => _todoItems[index],
        itemCount: _todoItems.length,
      );
      _donePage = new ListView.builder(
        itemBuilder: (BuildContext context, int index) => _doneItems[index],
        itemCount: _doneItems.length,
      );

      _currentPage = _todoPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_todoPage == null) {
      _buildItems();
    }

    var navBarItems = <BottomNavigationBarItem>[
      new BottomNavigationBarItem(
        icon: new Icon(Icons.event_note),
        title: new Text('Todo'),
        backgroundColor: Colors.orange,
      ),
      new BottomNavigationBarItem(
        icon: new Icon(Icons.done_all),
        title: new Text('Done'),
        backgroundColor: Colors.purple,
      ),
    ];

    return new Theme(
      data: new ThemeData(
        canvasColor: Colors.blueGrey[50],
      ),
      child:
      new Scaffold(
        body: _currentPage,
        bottomNavigationBar: new BottomNavigationBar(
          items: navBarItems,
          fixedColor: Colors.green,
          onTap: (value) => _chooseList(value),
          type: BottomNavigationBarType.fixed,
        ),
        resizeToAvoidBottomPadding: false,
      ),
    );
  }
}
