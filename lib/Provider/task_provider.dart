/**
 * Manages the data for our contacts
 */

import 'dart:async';
import 'package:connectivity/connectivity.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/Provider/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/task.dart';
import '../Provider/http_exception.dart';

import 'package:hive/hive.dart';

class Taskdata extends ChangeNotifier {



  // Name our hive box for this data
  String _boxName = "taskbox";

  // Initialize our list of task
  List<Task> _tasks = [];

  // Holds our active task
  Task? _activeTask;

  /// Get Contacts
  /// Gets all contacts from the hive box and loads them into our state List
  void getTasks() async {
    var box = await Hive.openBox<Task>(_boxName);

    // Update our provider state data with a hive read, and refresh the ui
    _tasks = box.values.toList();
    notifyListeners();
  }

  /// Get Contact
  /// Retrieves a specific contact from our state
  Task getTask(index) {
    return _tasks[index];
  }

  /// Contact Count
  /// Returns the length of the contact array
  int get taskCount {
    return _tasks.length;
  }

  /// Add Contact
  /// - Saves contact data to Hive box persistent storage
  /// - Updates our List with the hive data by read
  /// - Notifies listeners to update the UI, which will be a consumer of the _contacts List
  ///
  ///  CollectionReference students =
  Future<void> addTaskonhive(Task newTask) async {
    var box = await Hive.openBox<Task>(_boxName);

    // Add a contact to our box
    await box.add(newTask);
    CollectionReference Tasks =
    FirebaseFirestore.instance.collection('Tasks');
    // Update our provider state data with a hive read, and refresh the ui
    _tasks = box.values.toList();
    notifyListeners();
    // firebase adding the task

  }

  Future<void> addTask(Task newTask) async {
    var box = await Hive.openBox<Task>(_boxName);

    // Add a contact to our box
    await box.add(newTask);
    CollectionReference Tasks =
    FirebaseFirestore.instance.collection('Tasks');
    // Update our provider state data with a hive read, and refresh the ui
    _tasks = box.values.toList();
    notifyListeners();
   // firebase adding the task
    try{

      if (connectivity==false)
        {
          throw HttpException('Network_failed');

        }else{

        Tasks
            .add({'Task': newTask.task, 'Description': newTask.description, 'Date': newTask.date})
            .then((value) => print('User Added'))
            .catchError((error) => print('Failed to Add user: $error'));
      }
    }catch(error){

      throw connectivity;    }

  }

  /// Delete Contact
  void deleteTask(key) async {
    var box = await Hive.openBox<Task>(_boxName);

    await box.delete(key);

    // Update _contacts List with all box values
    _tasks = box.values.toList();

    print("Deleted task with key: " + key.toString());

    // Update UI
    notifyListeners();

  }

  /// Edit Contact
  /// Overwrites our existing contact based on key with a brand new updated Contact object
  void editTask({required Task task, required int taskKey}) async {
    var box = await Hive.openBox<Task>(_boxName);

    // Add a contact to our box
    await box.put(taskKey, task);

    // Update _contacts List with all box values
    _tasks = box.values.toList();

    // Update activeContact
    _activeTask = box.get(taskKey)!;

    print('New Name Of task: ' + task.task);

    // Update UI
    notifyListeners();
  }

  /// Set an active contact we can notify listeners for
  void setActiveContact(key) async {
    var box = await Hive.openBox<Task>(_boxName);
    _activeTask = box.get(key)!;
    notifyListeners();
  }

  /// Get Active Contact
  Task? getActiveContact() {
    return _activeTask;
  }
  late bool connectivity;
  Future <void>checkConectivity() async{
    late StreamSubscription subscription;
    subscription =
        Connectivity().onConnectivityChanged.listen(showConnectivitySnackBar);
  }
  bool showConnectivityStatus(
      ConnectivityResult? result) {
    final hasInternet = result != ConnectivityResult.none;
    return hasInternet;
  }
   showConnectivitySnackBar(
      ConnectivityResult result) {
    final hasInternet = result != ConnectivityResult.none;
    // 'You have again ${result.toString()}'
    connectivity=hasInternet;
    print('your phone is to connectted with netoek =$connectivity');
    final message = hasInternet
        ? 'You are now connected with Internet'
        : 'You have no internet';
    final color = hasInternet ? Colors.green : Colors.red;

  }
}
