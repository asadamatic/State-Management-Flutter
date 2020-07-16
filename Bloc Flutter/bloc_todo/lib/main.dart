import 'package:bloc_todo/CheckBloc.dart';
import 'package:bloc_todo/CheckListBloc.dart';
import 'package:bloc_todo/Task.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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

  final checkBloc = CheckBloc();
  final taskBloc = CheckListBloc();

  @override
  void dispose() {
    checkBloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: StreamBuilder<List<Task>>(
          stream: taskBloc.taskStream,
          builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot){
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text('${snapshot.data[index].title}'),
                  value: snapshot.data[index].status,
                  onChanged: (value) => taskBloc.taskChangeSink.add(snapshot.data[index]),
                );
              }
            );
          },
        )
      ),
    );
  }
}
