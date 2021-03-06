import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/task.dart';
import '../Providers/taskprovider.dart';

class ViewTask extends StatefulWidget {
  static const Routename ='/ViewTask';

  @override
  State<ViewTask> createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {
    int? index;
    @override
    void didChangeDependencies() {
      index = ModalRoute.of(context)?.settings.arguments as int?;
      super.didChangeDependencies();
    }

  @override
  Widget build(BuildContext context) {
    final data=Provider.of<Tasks>(context).tasks;
    print('Index is ${index}');
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
                          Text("Id : ${data[index!].id}"),
                          SizedBox(
                            width: 60,
                          ),
                          Icon(Icons.calendar_today_outlined),
                          Text("${data[index!].date}")
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
                      child: Text(data[index!].task),
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
                      child: Text(data[index!].description),
                    ),
                  ))




            ],
          )),
    );
  }
}

