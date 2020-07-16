class MyModel{
  String someValue = 'Hello';
  MyModel({this.someValue});

  void doSomething(){
    someValue = 'Did something';
    print('$someValue');
  }
}

Stream<MyModel> someStream(){
  return Stream<MyModel>.periodic(Duration(milliseconds: 100), (X) => MyModel(someValue: '$X')).take(20);
}