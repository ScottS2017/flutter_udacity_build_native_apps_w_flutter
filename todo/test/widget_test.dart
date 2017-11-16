// Unit & integration tests
import 'package:flutter_test/flutter_test.dart';

import '../lib/main.dart';

void main() {

  testWidgets('App launches to todo list page', (WidgetTester tester) async {
    await tester.pumpWidget(new TodoApp());
    expect(find.text('show done'), findsOneWidget);
  });

  testWidgets('Clicking on + goes to the create todo page', (WidgetTester tester) async {
    await tester.pumpWidget(new TodoApp());
    // Find the '+' widget
    var plusWidget = find.text('+');
    expect(plusWidget, findsOneWidget);
    // Tap and test the create todo page is rendered
    await tester.tap(plusWidget);
    await tester.pumpAndSettle();
    expect(find.text('create todo'), findsOneWidget);
  });
}
