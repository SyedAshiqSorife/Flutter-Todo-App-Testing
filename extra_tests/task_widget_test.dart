import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/models/todoList.dart';
import 'package:todolist/screens/tasks/task.dart';
import 'package:provider/provider.dart';
import 'package:todolist/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Task widget', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    final task = TaskModel(text: 'task 1');
    await tester.pumpWidget(MaterialApp(
        home: MultiProvider(
            providers: [
          ChangeNotifierProvider(create: (context) => TodoListModel()),
          ChangeNotifierProvider<TaskModel>.value(
            value: task,
          )
        ],
            child: Scaffold(
                // create a dummy scaffold to be able to use the TaskWidget
                appBar: AppBar(
                  title: Text('Task Widget Test'),
                ),
                body: TaskWidget()))));
    // find the task 1 text
    final textTask = find.text('task 1');
    expect(textTask, findsOneWidget);

    // find the checkboxListTile widget
    final checkboxListTile = find.byType(CheckboxListTile);
    expect(checkboxListTile, findsOneWidget);

    // check task is not completed
    expect(task.completed, false);
    await Future.delayed(Duration(seconds: 5));

    Text textWidgetBeforeTap = tester.widget(textTask) as Text;
    expect(textWidgetBeforeTap.style.decoration, TextDecoration.none);
    await tester.tap(checkboxListTile);

    // rebuilt widget after tap action
    await tester.pumpAndSettle();
    expect(task.completed, true);
    await Future.delayed(Duration(seconds: 5));
    Text textWidgetAfterTap = tester.widget(textTask) as Text;
    expect(textWidgetAfterTap.style.decoration, TextDecoration.lineThrough);
    await Future.delayed(Duration(seconds: 5));
  });
}
