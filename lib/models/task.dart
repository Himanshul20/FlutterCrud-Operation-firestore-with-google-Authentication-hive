import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject{
  @HiveField(0)
  String? id;
  @HiveField(1)
  String task;
  @HiveField(2)
  DateTime? date;
  @HiveField(3)
  String description;

  Task({ this.id, required this.task, required this.description, this.date});





}



