import 'package:flutter/cupertino.dart';

class TimerInfo extends ChangeNotifier{

  DateTime _timer = DateTime.now();
  DateTime getTime() => _timer;

  updateTimer(){
    _timer = DateTime.now();
    notifyListeners();
  }
}