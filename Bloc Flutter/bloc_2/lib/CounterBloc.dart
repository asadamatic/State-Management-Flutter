import 'dart:async';

import 'package:bloc_2/Counter.dart';

class CounterBloc{

  int _counter = 0;

  final counterController = StreamController<int>();
  StreamSink get _inCounter => counterController.sink;
  Stream get outCounter => counterController.stream;

  final counterEventController = StreamController<CounterEvent>();
  StreamSink get counterEventSink => counterEventController.sink;

  CounterBloc(){
    counterEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CounterEvent event) {
    if (event is incrementCounterEvent){
      _counter++;
    }else{

      _counter--;
    }

    _inCounter.add(_counter);
  }

  void dispose(){
    counterController.close();
    counterEventController.close();
  }
}