// Shows our entire list of contacts, made up of contact_tile objects.
import 'package:flutter/material.dart';
import '../Provider/task_provider.dart';
import 'task_tile.dart';
import 'package:provider/provider.dart';

class ContactsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return TaskTile(tileIndex: index);
      },
      itemCount: Provider.of<Taskdata>(context).taskCount,
    );
  }
}
