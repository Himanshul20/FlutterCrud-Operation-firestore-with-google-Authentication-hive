import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/task.dart';
import '../Providers/taskprovider.dart';

class EditTask extends StatefulWidget {
  static const Routename = '/EditTask';

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final _form = GlobalKey<FormState>();

  var index;
  var _edittask = Task(
    id: '',
    task: '',
    description: '',
  );

  @override
  void didChangeDependencies() {
    if(index!=null)
    index = ModalRoute.of(context)!.settings.arguments ;
    else
      index=0;
    super.didChangeDependencies();
  }

  void _saveForm()  {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
     if(index!=null){
       print('i m here in not equal to null');
       Provider.of<Tasks>(context,listen: false).add(_edittask);
     }


  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Tasks>(context).tasks;
    print('Index is ${index}');
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
                          initialValue: data[index].task,
                          decoration: InputDecoration(),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please provide a value.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _edittask = Task(
                              task: value!,
                              description: _edittask.description,
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
                          initialValue: data[index!].description,
                          decoration: InputDecoration(),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please provide a value.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _edittask = Task(
                                id: _edittask.id,
                                task: _edittask.task,
                                date: _edittask.date,
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
