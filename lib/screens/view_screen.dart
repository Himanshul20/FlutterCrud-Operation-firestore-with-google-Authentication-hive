import 'package:crud/Provider/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../widgets/backbutton.dart';
import '../widgets/task_list.dart';
import '../widgets/viewtask.dart';
import 'edit_screen.dart';


class ViewContent extends StatefulWidget {
  const ViewContent({Key? key}) : super(key: key);

  static const Routename = '/ViewContent';

  @override
  State<ViewContent> createState() => _ViewContentState();
}

class _ViewContentState extends State<ViewContent> {
  @override
  Widget build(BuildContext context) {
    Provider.of<Taskdata>(context, listen: false).getTasks();
    var task = Provider.of<Taskdata>(context, listen: false);
    return Consumer<Taskdata>(builder: (context, contactData, child) {
      Task? currentContact = contactData.getActiveContact();
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
                  left: 5,
                  height: 60,
                  width: 10,
                  child: Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: GestureDetector(
                        onTap: (){
                          print('hello');
                          Navigator.pushNamed(context, '/');
                        },
                        child: Icon(
                          Icons.home,
                          size: 30,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  )),
              Positioned(
                  top: 380,
                  left: 40,
                  height: 400,
                  width: 310,
                  child: Container(
                    child: ContactsList(),
                  )),
              Positioned(
                  top: 300,
                  left: 40,
                  height: 60,
                  width: 10,
                  child: AbsorbPointer(
                    child: Container(
                      color: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: GestureDetector(

                          onTap:(){
                            Navigator.pushNamed(context, '/AddContactScreen');

                          } ,
                          child: IgnorePointer(
                            child: Icon(
                              Icons.add_circle,
                              size: 30,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
              Positioned(
                  top: 40,
                  left: 8,
                  height: 60,
                  width: 10,
                  child: Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: BackButton(onPressed: (){
                        print('hello');
                        Navigator.pop(context);
                      },),
                    ),
                  )),
              Positioned(
                  top: 309,
                  right: 30,
                  height: 60,
                  width: 10,
                  child: Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "${task.taskCount}",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  )),
              Positioned(
                  top: 300,
                  right: 70,
                  height: 60,
                  width: 10,
                  child: Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        Icons.content_paste,
                        size: 30,
                        color: Colors.blueAccent,
                      ),
                    ),
                  )),
            ],
          )),
    );
    });
  }


}
