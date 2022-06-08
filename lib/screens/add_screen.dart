import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../Provider/task_provider.dart';
import '../widgets/common_toast.dart';
import '../Provider/http_exception.dart';


class ContactAddScreen extends StatefulWidget {
  @override
  _ContactAddScreenState createState() => _ContactAddScreenState();
}

class _ContactAddScreenState extends State<ContactAddScreen> {
   String newTask='';
   String newDescription='';
   DateTime newDate=DateTime.now();
@override
  void initState() {
    // TODO: implement initState

  super.initState();
  }

   Future<void> _addContact(context) async{
    /// Validate the client name input
    if (newTask == '') {
      commonToast("You must include a name.");
      return;
    }
    if (newDescription == '') {
      commonToast("You must include a Description.");
      return;
    }
    if (newTask.length < 3) {
      commonToast("The name must be at least 3 characters.");
      return;
    }

    /// Save contact data, email and phone are optional - null values replaced by empty string
    try{
      if(Provider.of<Taskdata>(context, listen: false).connectivity==false){
        Provider.of<Taskdata>(context, listen: false).addTaskonhive(
          Task(
            task: (newTask != '') ? newTask : '',
            date:  DateTime.now().toString(),
            description: (newDescription != '') ? newDescription : '',
          ),
        );
        Navigator.pop(context);

        _showErrorDialog("Check your network connection data saved on hive");

      }else{
        Provider.of<Taskdata>(context, listen: false).addTask(
          Task(
            task: (newTask != '') ? newTask : '',
            date:  DateTime.now().toString(),
            description: (newDescription != '') ? newDescription : '',
          ),
        );
        Navigator.pop(context);
      }



    }on HttpException catch (error) {
      var errorMessage = "Something went wrong";
      if(error.toString().contains('Network_failed'))
        {
          errorMessage="Please check internet Connectivity";
        }
      _showErrorDialog(errorMessage);

    }

    catch(error){

    }
  }
   void _showErrorDialog(String message) {
     showDialog(
       context: context,
       builder: (ctx) => AlertDialog(
         title: Text('An Error Occurred!'),
         content: Text(message),
         actions: <Widget>[
           FlatButton(
             child: Text('Okay'),
             onPressed: () {
               Navigator.of(ctx).pop();
             },
           )
         ],
       ),
     );
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
                        decoration: InputDecoration(
                          hintText: "Task ",

                        ),
                        textInputAction: TextInputAction.next,

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

                        decoration: InputDecoration(
                            hintText: "Description "

                        ),
                        textInputAction: TextInputAction.next,

                        autofocus: true,
                        onChanged: (value) {
                          setState(() {
                            newDescription = value;
                          });
                        },
                        onFieldSubmitted: (_) {
                          _addContact(context);
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

                            _addContact(context);
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
