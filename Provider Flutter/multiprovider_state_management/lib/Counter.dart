import 'package:flutter/cupertino.dart';

class Counter extends ChangeNotifier{
  int _count = 0;

  int getCount() => _count;

  incrementCounter(){
    _count++;
    notifyListeners();
  }
}