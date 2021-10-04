import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/models/todoList.dart';
import 'package:todolist/screens/completed_tasks/completed_tasks.dart';
import 'package:todolist/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Test Todolist widget', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    final todoList = TodoListModel();
    final task = TaskModel(text: "task 1");
    final task2 = TaskModel(text: "task 2");
    final task3 = TaskModel(text: "task 3", completed: true);
    todoList.addTaks(task);
    todoList.addTaks(task2);
    todoList.addTaks(task3);
    await Future.delayed(Duration(seconds: 3));
    await tester.pumpWidget(
      MaterialApp(home: CompletedTasks(todoList: todoList)),
    );

    final textTask1 = find.text('task 1');
    final textTask2 = find.text('task 2');
    final textTask3 = find.text('task 3');
    expect(textTask1, findsNothing);
    expect(textTask2, findsNothing);
    await Future.delayed(Duration(seconds: 3));
    expect(textTask3, findsOneWidget);
    await tester.pumpAndSettle();
    await Future.delayed(Duration(seconds: 3));
  });
}
