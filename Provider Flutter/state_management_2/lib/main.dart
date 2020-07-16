import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_2/counter.dart';

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
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<Counter>(
            create:  (context) => Counter(),
          ),
          ChangeNotifierProvider<ValueNotifier<int>>(
            create: (_) => ValueNotifier<int>(0),
          ),
          ChangeNotifierProvider<ValueNotifier<String>>.value(
            value:  ValueNotifier<String>('You have pushed the button this many times:'),
          )
        ],
        child: MyHomePage(title: 'Flutter Demo Home Page')),
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
  

  @override
  Widget build(BuildContext context) {
    print('Set State called');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
      
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer<ValueNotifier<String>>(
              builder: (context, data, child){

                return Text(
                  '${data.value}',
                );
              },
            ),
            Consumer<Counter>(

              builder: (context, data, child){

                return Text(
                  '${data.getCounter()}',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
            Consumer<ValueNotifier<int>>(

              builder: (context, data, child){

                return Text(
                  '${data.value}',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Provider.of<Counter>(context, listen: false).incrementCounter();
          Provider.of<ValueNotifier<int>>(context, listen: false).value++;
          Provider.of<ValueNotifier<String>>(context, listen: false).value = 'UI UPDATED';
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
