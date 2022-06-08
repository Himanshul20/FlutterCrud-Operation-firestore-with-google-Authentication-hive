import 'package:crudoperation/Screens/viewcontent.dart';
import 'package:crudoperation/Widgets/edit_task.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  static const  Routename ='/HomeScreen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/homescreen.jpg"),
              fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            Positioned(
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
                            primary: Colors.deepPurple,
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                        onPressed: () {
                            Navigator.pushNamed(context, EditTask.Routename);

                        },
                        child: Text('Add Task'),
                      ),
                    ),
                  ),
                )
            ),
            Positioned(
                top: 650,
                left: 40,
                height: 60,
                width: 310,
                child: Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(

                        style:  ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black45,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                      onPressed: () { Navigator.pushNamed(context, ViewContent.Routename); },
                      child: Text('View All'),
                    ),
                  ),
                )
            )
          ],
        )
      ),
    );
  }
}
