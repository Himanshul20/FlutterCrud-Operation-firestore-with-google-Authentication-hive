import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/task.dart';
import '../Providers/taskprovider.dart';

class AddTask extends StatefulWidget {
  static const Routename = '/AddTask';

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _form = GlobalKey<FormState>();

  var _addtask = Task(
    id: '',
    task: '',
    description: '',
    date: DateTime.now(),
  );

  @override

  void _saveForm()  {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
 print('dhbjhdvjdvjhdvjvdhvdh');

      Provider.of<Tasks>(context,listen: false).add(_addtask);




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
          child: Form(
            key: _form,
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
                          decoration: InputDecoration(label: Text('Task')),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please provide a value.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _addtask = Task(
                              task: value!,
                              description: _addtask.description,
                            );
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
                          decoration: InputDecoration(label: Text("Description")),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please provide a value.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _addtask = Task(
                                id: _addtask.id,
                                task: _addtask.task,
                                description: value!);
                          },
                          onFieldSubmitted: (_) {
                            _saveForm();
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
                              _saveForm;
                              Navigator.pop(context);
                            },
                            child: Text('Save'),
                          ),
                        ),
                      ),
                    )
                )
              ],
            ),
          )),
    );
  }
}
