import 'package:bloc_1/EmployeeBloc.dart';
import 'package:bloc_1/EmployeeData.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key,}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final EmployeeBloc _employeeBloc = EmployeeBloc();

  @override
  void dispose() {
    _employeeBloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Data'),
      ),
      body: Container(
        child: StreamBuilder<List<EmployeeData>>(
          stream: _employeeBloc.employeeListStream,
          builder: (BuildContext context, AsyncSnapshot<List<EmployeeData>>snapshot){

            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index){
                final _employeeData = snapshot.data[index];
                return EmployeeCard(UniqueKey(), _employeeData, _employeeBloc);
              }
              );
          },
        )
      ),
    );
  }
}

class EmployeeCard extends StatefulWidget{

  EmployeeData _employeeData;
  EmployeeBloc _employeeBloc;
  Key key;
  EmployeeCard(this.key, this._employeeData, this._employeeBloc);
  @override
  State createState() {
    return EmployeeCardState();
  }
}

class EmployeeCardState extends State<EmployeeCard>{


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(width: 20.0,),
              Text('${widget._employeeData.id}', style: TextStyle(fontSize: 24.0),),
              SizedBox(width: 20.0,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('${widget._employeeData.name}', style: TextStyle(fontSize: 24.0,),),
                  SizedBox(height: 5.0,),
                  Text('Pkr ${widget._employeeData.salary}', style: TextStyle(fontSize: 20.0, color: Colors.grey[700]),),
                ],
              ),
            ],
          ),
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_up,
                  color: Colors.greenAccent,
                ),
                iconSize: 30.0,
                onPressed: (){
                  widget._employeeBloc.employeeSalaryIncrementSink.add(widget._employeeData);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.redAccent,
                ),
                iconSize: 30.0,
                onPressed: (){
                  widget._employeeBloc.employeeSalaryDecrementSink.add(widget._employeeData);

                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
