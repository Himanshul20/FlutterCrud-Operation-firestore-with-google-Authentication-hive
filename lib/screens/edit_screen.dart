import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/common_toast.dart';
import '../Provider/task_provider.dart';
import '../models/task.dart';

class EditScreen extends StatefulWidget {
  final Task currentTask;
  EditScreen({required this.currentTask});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late String newTask;
  late String newDescription;
  late DateTime newDate;

  void _editContact(context) {
    /// Validate the client name input
    if (newTask == null) {
      commonToast("You must include a name.");
      return;
    }
    if (newTask.length < 3) {
      commonToast("The name must be at least 3 characters.");
      return;
    }

    /// Save contact data, email and phone are optional - null values replaced by empty string
    Provider.of<Taskdata>(context, listen: false).editTask(
      task: Task(
        task: newTask,
        date: DateTime.now().toString(),
        description: (newDescription != '') ? newDescription : '',
      ),
      taskKey: widget.currentTask.key,
    );
    Navigator.pop(context);
  }

  // Controllers for form text controllers
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    /// Set the initial text field value and state value for the currentClient on initial load
    _taskController.text = widget.currentTask.task;
    newTask = widget.currentTask.task;
    _descriptionController.text = widget.currentTask.description;
    newDescription = widget.currentTask.description;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<Taskdata>(context,listen: false).checkConectivity();

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
                      child: TextFormField(
                        autofocus: true,
                          controller: _taskController,
                        decoration: InputDecoration(),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a value.';
                          }
                          return null;
                        },
                          onChanged: (Value) {
                            setState(() {
                              newTask = Value;
                            });
                          },
                      ),
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
                      child: TextFormField(
                        maxLines: 3,
                        decoration: InputDecoration(),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a value.';
                          }
                          return null;
                        },
                          autofocus: true,
                          controller: _descriptionController,
                          onChanged: (value) {
                            setState(() {
                              newDescription = value;
                            });
                          },
                        onFieldSubmitted: (_) {
                          _editContact(context);
                        },
                      ),
                    ),
                  ))
              ,            Positioned(
                  top: 580,
                  left: 40,
                  height: 60,
                  width: 310,
                  child: Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: SizedBox(
                        height: 30,
                        child: ElevatedButton(
                          style:  ElevatedButton.styleFrom(
                            primary:  Color.fromRGBO(25, 32, 65, 1),
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                          onPressed: (){
                            _editContact(context);
                            Navigator.pop(context);
                          },
                          child: Text('Save'),
                        ),
                      ),
                    ),
                  )
              )
            ],
          )),
    );
  }
}
