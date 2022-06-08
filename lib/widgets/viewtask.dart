import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/task_provider.dart';
import '../models/task.dart';


class ViewTask extends StatefulWidget {
  static const Routename ='/ViewTask';
  final Task currentContact;
  ViewTask({required this.currentContact});

  @override
  State<ViewTask> createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {
  late String newTask;
  late String newDescription;
  late String date;

    @override
    void initState() {
      /// Set the initial text field value and state value for the currentClient on initial load
      newTask = widget.currentContact.task;

      date=widget.currentContact.date;
      newDescription = widget.currentContact.description;

      super.initState();
    }


    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/view.png"), fit: BoxFit.cover),
          ),
          child: Stack(
            children: [

              Positioned(
                  top: 300,
                  left: 30,
                  height: 60,
                  width: 330,
                  child: Container(

                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(170, 212, 234, 1.0),


                      borderRadius: BorderRadius.circular(10),
                    ),
                    // color: Colors.grey,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Text("Id : 1"),
                          SizedBox(
                            width: 60,
                          ),
                          Icon(Icons.calendar_today_outlined),
                          Text(date)
                        ],
                      ),
                    ),
                  )),
              Positioned(
                  top: 390,
                  left: 30,
                  height: 50,
                  width: 330,
                  child: Container(

                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(170, 212, 234, 1.0),


                      borderRadius: BorderRadius.circular(10),
                    ),
                    // color: Colors.grey,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(newTask),
                    ),
                  )),
              Positioned(
                  top: 470,
                  left: 30,
                  height: 100,
                  width: 330,
                  child: Container(

                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(170, 212, 234, 1.0),


                      borderRadius: BorderRadius.circular(10),
                    ),
                    // color: Colors.grey,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(newDescription),
                    ),
                  ))




            ],
          )),
    );
  }
}

