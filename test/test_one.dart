import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:todolist/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Add a new task', (WidgetTester tester) async {
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
  });
}
