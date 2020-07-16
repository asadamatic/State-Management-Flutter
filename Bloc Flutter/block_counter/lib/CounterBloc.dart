import 'dart:async';

class CounterBloc{

  //Data private
  int counter = 0;

  //Stream controller
  final _counterStreamController = StreamController<int>();
  final _counterIncrementStreamController = StreamController<int>();
  final _counterDecrementStreamController = StreamController<int>();

  Stream<int> get counterStream => _counterStreamController.stream;
  StreamSink<int> get counterSink => _counterStreamController.sink;

  StreamSink<int> get counterIncrementSink => _counterIncrementStreamController.sink;
  StreamSink<int> get counterDecrementSink => _counterDecrementStreamController.sink;
  CounterBloc(){
    _counterStreamController.add(counter);
    _counterIncrementStreamController.stream.listen(_incrementCounter);
    _counterDecrementStreamController.stream.listen(_decrementCounter);
  }

  void _incrementCounter(int event) {
    event++;
    counter = event;
    counterSink.add(counter);
  }

  void dispose(){
    _counterStreamController.close();
    _counterIncrementStreamController.close();
    _counterDecrementStreamController.close();
  }

  void _decrementCounter(int event) {
    event--;
    counter = event;
    counterSink.add(counter);
  }
}