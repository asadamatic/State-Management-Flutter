import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_practice/CustomCheckBox.dart';
import 'package:provider_practice/DataModel/TaskData.dart';
import 'package:provider_practice/DatabaseConnection/database.dart';
import 'package:provider_practice/EditingDialog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CustomDatabase>(
      create: (context) => CustomDatabase(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  CustomDatabase customDatabase = CustomDatabase();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    customDatabase.initializeDB();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Consumer<CustomDatabase>(
        builder: (context, taskData, child){
          return FutureBuilder<List<TaskData>>(
            future: taskData.retrieve(DateTime.now()),
            builder: (context, snapshot) {

              if (snapshot.hasData){

                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index){
                    return CustomCheckBox(key: UniqueKey(), taskData: snapshot.data[index],);
                  },
                );
              }
              return Center(child: CircularProgressIndicator());
            }
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await showDialog(context: context, builder: (context){
            return EditingDialog(selectedDate: DateTime.now(),);
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
