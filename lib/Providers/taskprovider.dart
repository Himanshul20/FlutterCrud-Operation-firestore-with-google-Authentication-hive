import 'package:flutter/material.dart';

import '../Models/task.dart';
import '../Models/task.dart';
class Tasks with ChangeNotifier {



  List <Task> _data=[
    Task(id: '1', task: 'Project Manager', description: 'description',date: DateTime.now()),
    Task(id: '2', task: 'Flutter Project', description: 'description',date: DateTime.now())
  ];

  List<Task> get tasks {

    return [..._data];
  }
  void add(Task task){
    _data.add(task);
  }
   update(int index,Task task){
    _data[index].task=task.task;
  }



}