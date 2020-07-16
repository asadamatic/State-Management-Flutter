import 'package:flutter/material.dart';
import 'package:multiprovider_state_management/Counter.dart';
import 'package:multiprovider_state_management/MyModel.dart';
import 'package:provider/provider.dart';

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
            ChangeNotifierProvider.value(value: Counter()),
            FutureProvider<MyModel>(
              initialData: MyModel(someValue: 'Default value'),
              create: (context) => someAsyncFunctionToGetMyModel(),
            )
          ],
          child: MyHomePage(title: 'Flutter Demo Home Page'),
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


  void _incrementCounter() {
    Provider.of<Counter>(context, listen: false).incrementCounter();
    Provider.of<MyModel>(context, listen: false).doSomething();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer<MyModel>(
              builder: (context, data, child){

                return Text(
                  '${data.someValue}',
                );
              },
            ),
            Consumer<Counter>(
              builder: (context, data, child){
                return Text(
                  '${data.getCount()}',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
