import 'package:bloc_sqlite/StringBloc.dart';
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

  final bloc = StringBloc();
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.getNamesSink.add(bloc.names);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: controller,
          ),
          Flexible(
            child: StreamBuilder<List<String>>(
              stream: bloc.namesStream,
              builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot){

                return ListView.builder(
                  shrinkWrap: true,
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index){

                      return Text('${snapshot.data[index]}');
                    },
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          bloc.insertNameSink.add(controller.text);
          bloc.getNamesSink.add(bloc.names);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
