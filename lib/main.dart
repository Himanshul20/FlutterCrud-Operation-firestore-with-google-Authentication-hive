import 'package:crudoperation/Providers/taskprovider.dart';
import 'package:crudoperation/Screens/home_Screen.dart';
import 'package:crudoperation/Screens/viewcontent.dart';
import 'package:crudoperation/Widgets/add_task.dart';
import 'package:crudoperation/Widgets/edit_task.dart';
import 'package:crudoperation/Widgets/viewtask.dart';


import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'Models/task.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('task');


  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: Tasks())
    ],
    child: MaterialApp(
      title: 'MyShop',


      routes: {
        '/':(ctx)=>HomeScreen(),
        ViewContent.Routename:(ctx)=>ViewContent(),
        ViewTask.Routename:(ctx)=>ViewTask(),
        EditTask.Routename:(ctx)=>EditTask(),
        AddTask.Routename:(ctx)=>AddTask()

      },
    ),);
  }
}

