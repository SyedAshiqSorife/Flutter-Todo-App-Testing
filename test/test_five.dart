import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:todolist/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Task remove from completed task page',
      (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    final textField = find.byType(TextField);
    //expect(textField, findsOneWidget);
    // enter text in field

    await tester.enterText(textField, 'New Task');
    await tester.pumpAndSettle();
    //await Future.delayed(Duration(seconds: 5));
    final textFieldWidget = tester.widget(textField) as TextField;
    //await Future.delayed(Duration(seconds: 5));
    String text = textFieldWidget.controller.value.text;
    textFieldWidget.onSubmitted(textFieldWidget.controller.value.text);
    await tester.pumpAndSettle();
    print(text);

    // find new task created
    expect(find.byType(CheckboxListTile), findsOneWidget);
    expect(find.text('New Task'), findsOneWidget);
    await Future.delayed(Duration(seconds: 2));

    //click on new task
    final checkboxListTile = find.byType(CheckboxListTile);
    await tester.tap(checkboxListTile);
    await tester.pumpAndSettle();

    //check i completed task page
    final completed = find.byType(IconButton);
    await tester.tap(completed);
    await tester.pumpAndSettle();
    await Future.delayed(Duration(seconds: 2));

    //back to home page
    final back = find.byType(BackButton);
    await tester.tap(back);
    await tester.pumpAndSettle();
    await Future.delayed(Duration(seconds: 2));

    //again click on new task
    await tester.tap(checkboxListTile);
    await tester.pumpAndSettle();

    //check task remove on completed page
    await tester.tap(completed);
    await tester.pumpAndSettle();
    await Future.delayed(Duration(seconds: 2));
  });
}
