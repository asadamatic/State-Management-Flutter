import 'package:block_counter/CounterBloc.dart';
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

  final counterBloc = CounterBloc();

  @override
  void dispose() {
    counterBloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: StreamBuilder<int>(
          stream: counterBloc.counterStream,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot){

            return Text("${snapshot.data}", style: TextStyle(fontSize: 24.0),);
          },
        ),
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(
          child: Text('Decrement Counter'),
          onPressed: () => counterBloc.counterDecrementSink.add(counterBloc.counter),
        )
      ],
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          counterBloc.counterIncrementSink.add(counterBloc.counter);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
