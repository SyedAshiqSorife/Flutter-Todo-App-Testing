import 'package:integration_test/integration_test.dart';
import 'package:todolist/models/task.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todolist/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  test('Decode and encode task to json', () {
    app.main();

    final json = {'text': 'task #1', 'completed': true};
    final TaskModel t = TaskModel.fromJson(json);
    Timeout(Duration(seconds: 3));
    expect(t.completed, true);
    expect(t.text, 'task #1');
    expect(t.toJson(), json);
  });

  test('Toggle task completed/uncompleted', () {
    app.main();
    final item = TaskModel(text: 'new item', completed: false);
    Timeout(Duration(seconds: 3));
    pumpEventQueue();
    item.toggle();
    Timeout(Duration(seconds: 3));
    expect(item.completed, true);
    item.toggle();
    pumpEventQueue();
    Timeout(Duration(seconds: 3));
    expect(item.completed, false);
    Timeout(Duration(seconds: 3));
  });
}
