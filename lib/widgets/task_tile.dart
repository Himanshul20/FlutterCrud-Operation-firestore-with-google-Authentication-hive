// The display of a single contact

import 'package:crud/widgets/viewtask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import '../screens/edit_screen.dart';
import '../screens/view_screen.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../Provider/task_provider.dart';

class TaskTile extends StatelessWidget {
  final int tileIndex;

  // Constructor
  TaskTile({required this.tileIndex});

  @override
  Widget build(BuildContext context) {
    return Consumer<Taskdata>(
      builder: (context, taskData, child) {
        Task currenttask = taskData.getTask(tileIndex);

        return SwipeActionCell(
          ///this key is necessary

          key: ObjectKey(currenttask),
          trailingActions: <SwipeAction>[
            SwipeAction(

                performsFirstActionWithFullSwipe: true,
            icon:Icon(Icons.edit,color: Colors.blue,) ,
                onTap: (CompletionHandler handler)  {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return bottomsheetcontainer(
                          context, tileIndex,currenttask);
                    },
                  );
                },
                color: Colors.grey),
            SwipeAction(

                performsFirstActionWithFullSwipe: true,
                icon:Icon(Icons.delete,color: Colors.red,) ,
                onTap: (CompletionHandler handler) async {
                  _delete(context: context,key: currenttask.key);
                },
                color: Colors.grey)
          ],
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Text(
                "${currenttask.task}",
              ),
            ),
          ),
        );
      },
    );
  }
  Widget bottomsheetcontainer(BuildContext context, int id, Task? currentTask) {
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ViewTask(
                            currentContact: currentTask!,

                          );
                        },
                      ));
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return EditScreen(
                            currentTask: currentTask!,
                          );
                        },
                      ));
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
  Future<bool> _delete({required int key, required BuildContext context}) async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to Delete this Task'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<Taskdata>(context,listen: false).deleteTask(key);
              Navigator.pop(context);
            },
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }


}
