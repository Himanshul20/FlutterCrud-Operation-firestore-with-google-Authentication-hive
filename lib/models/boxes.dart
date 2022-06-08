import 'package:crudoperation/Models/task.dart';
import 'package:hive/hive.dart';


class Boxes {
  static Box<Task> getTask() =>
      Hive.box<Task>('task');


}
