import 'package:flutter/material.dart';

class Backbutton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back,color: Colors.blue,));
  }
}
