

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:provider_practice/DataModel/TaskData.dart';
import 'package:provider_practice/DatabaseConnection/database.dart';
import 'package:sqflite/sqflite.dart';

class EditingDialog extends StatefulWidget{

  DateTime selectedDate;
  TaskData taskData;
  EditingDialog({this.selectedDate, this.taskData});

  @override
  _EditingDialogState createState() => _EditingDialogState();
}

class _EditingDialogState extends State<EditingDialog> {

  //Task editing controller
  TextEditingController taskController = TextEditingController();

  void edit()async{
    setState(() {
      widget.taskData.title = taskController.text;
    });
    await Provider.of<CustomDatabase>(context, listen: false).update(widget.taskData);
    Navigator.of(context).pop();
  }
  void add() async {
    TaskData newTaskData = TaskData(title: taskController.text, date: DateFormat('d/M/y').format(widget.selectedDate), status: false);
    await Provider.of<CustomDatabase>(context, listen: false).insert(newTaskData);
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {

    taskController.text = widget.taskData == null ? '' : widget.taskData.title;

    return AlertDialog(
      title: Text(widget.taskData == null ? 'New Task' : 'Edit Task'),
      content: TextField(
        controller: taskController,
        autofocus: true,
        decoration: InputDecoration(
          hintText: 'Task Name',
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel', style: TextStyle(color: Colors.grey),),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text(widget.taskData == null ? 'Add' : 'Update', style: TextStyle(color: Colors.blue),),
          onPressed: widget.taskData == null ? add : edit,
        )
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    taskController.dispose();
    super.dispose();
  }
}