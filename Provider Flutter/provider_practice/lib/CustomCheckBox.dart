import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:provider_practice/DataModel/TaskData.dart';
import 'package:provider_practice/DatabaseConnection/database.dart';
import 'package:provider_practice/EditingDialog.dart';


class CustomCheckBox extends StatefulWidget {

  TaskData taskData;
  Key key;
  CustomCheckBox({this.key, this.taskData,});

  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<CustomDatabase>(context);
    return Card(
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
        elevation: 3.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.5),
        child: CheckboxListTile(
          value: widget.taskData.status,
          onChanged: (newValue){
            setState(() {
              widget.taskData.status = newValue;

            });
            database.update(widget.taskData);
          },
          controlAffinity: ListTileControlAffinity.leading,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(child: Text('${widget.taskData.title}')),
              IconButton(

                icon: Icon(
                  Icons.edit,
                  size: 21.0,
                ),
                onPressed: () async{
                  showDialog(context: context,
                      barrierDismissible: false,
                      builder: (context){

                        return EditingDialog(taskData: widget.taskData,);
                      }
                  );
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  size: 21.0,
                ),
                onPressed: (){
                    database.delete(widget.taskData);
                },
              )
            ],
          ),
        )
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
