import 'package:flutter/material.dart';

class Counter extends ChangeNotifier{

  int _counter = 0;

  int getCounter() => _counter;

  incrementCounter() {

    _counter++;
    notifyListeners();
  }

}