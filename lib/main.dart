import 'package:crud/screens/add_screen.dart';
import 'package:crud/screens/home_Screen.dart';
import 'package:crud/screens/list_screen.dart';
import 'package:crud/screens/login_screen.dart';
import 'package:crud/screens/view_screen.dart';
import 'package:crud/widgets/viewtask.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'models/task.dart';
import 'Provider/task_provider.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(TaskAdapter());
  runApp(MyApp());
}

Future _initHive() async {
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
final Future <FirebaseApp> _intialization =Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => Taskdata(),
      child: MaterialApp(
        title: 'Crud Hive',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => FutureBuilder(
            future: _initHive(),
            builder: (context, snapshot) {

              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.error != null) {
                  print(snapshot.error);
                  return Scaffold(
                    body: Center(
                      child: Text('Error initializing hive data store.'),
                    ),
                  );
                } else {
                  return LoginScreen();
                }
              } else {
                return Scaffold();
              }
            },
          ),
          '/AddContactScreen': (context) => ContactAddScreen(),
          LoginScreen.Routename:(ctx)=>LoginScreen(),
          HomeScreen.Routename:(ctx)=>HomeScreen(),
          ViewContent.Routename:(ctx)=>ViewContent()
        },
      ),
    );
  }
}
