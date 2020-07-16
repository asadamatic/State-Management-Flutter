import 'dart:async';

import 'package:bloc_todo/Task.dart';

class CheckListBloc{

  List<Task> tasks = [Task(1 , 'Workout', false), Task(2 , 'Study', false), Task(3 , 'Flutter', false)];

  final _tasksStreamController = StreamController<List<Task>>();
  final _taskStatusChangeController = StreamController<Task>();

  Stream<List<Task>> get taskStream => _tasksStreamController.stream;
  StreamSink<List<Task>> get taskSink => _tasksStreamController.sink;

  StreamSink<Task> get taskChangeSink => _taskStatusChangeController.sink;

  CheckListBloc(){
    _tasksStreamController.add(tasks);
    _taskStatusChangeController.stream.listen(_changeStatus);
  }

  void _changeStatus(Task task) {

    tasks[task.id - 1].status = !task.status;
    taskSink.add(tasks);
  }

  void dispose(){
    _tasksStreamController.close();
    _taskStatusChangeController.close();
  }
}