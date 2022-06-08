/**
 * Our contact data model
 */

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0) // use Hive to generate a type adapter
class Task extends HiveObject {
  // Define variables

  @HiveField(0)
  final String task;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final String date;

  // Constructor
  Task({required this.task, required this.description, required this.date});
}
