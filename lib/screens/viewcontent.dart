import 'package:crudoperation/Providers/taskprovider.dart';
import 'package:crudoperation/Screens/home_Screen.dart';
import 'package:crudoperation/Widgets/viewtask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:provider/provider.dart';

import '../Widgets/edit_task.dart';

class ViewContent extends StatefulWidget {
  const ViewContent({Key? key}) : super(key: key);

  static const Routename = 'ViewContent';

  @override
  State<ViewContent> createState() => _ViewContentState();
}

class _ViewContentState extends State<ViewContent> {
  @override
  Widget build(BuildContext context) {
    final Task = Provider.of<Tasks>(context).tasks;

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
                  child: GestureDetector(
                    onTap: (){
                      print('hello');
                      Navigator.pushNamed(context, '/');
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.all(5),
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
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return Divider(
                          height: 10,
                          color: Colors.transparent,
                        );
                      },
                      itemCount: Task.length,
                      itemBuilder: (context, index) {
                        return SwipeActionCell(
                          ///this key is necessary

                          key: ObjectKey(Task[index]),
                          trailingActions: <SwipeAction>[
                            SwipeAction(

                                ///this is the same as iOS native
                                ///

                                performsFirstActionWithFullSwipe: true,
                                title: "edit",
                                onTap: (CompletionHandler handler) async {
                                  showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return bottomsheetcontainer(
                                          context, index);
                                    },
                                  );
                                },
                                color: Colors.red),
                          ],
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Center(
                              child: Text(
                                "${Task[index].task}",
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )),
              Positioned(
                  top: 300,
                  left: 40,
                  height: 60,
                  width: 10,
                  child: Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        Icons.add_circle,
                        size: 30,
                        color: Colors.black87,
                      ),
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
                        "${Task.length}",
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
  }

  Widget bottomsheetcontainer(BuildContext context, int id) {
    return Container(
      height: 200,
      color: Colors.grey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 50,
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(25, 32, 65, 1),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, ViewTask.Routename,
                      arguments: id);
                },
                child: Text(
                  'View',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(25, 32, 65, 1),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                onPressed: () {
                  print('id is ${id}');
                  Navigator.of(context)
                      .pushNamed(EditTask.Routename, arguments: id);
                },
                child: Text(
                  'Edit',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
