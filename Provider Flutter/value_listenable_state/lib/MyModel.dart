import 'package:flutter/foundation.dart';

class MyModel {

  ValueNotifier<String> someValue = ValueNotifier('Hello');

  void doSomething(){
    someValue.value = 'You did somethng';
  }
}