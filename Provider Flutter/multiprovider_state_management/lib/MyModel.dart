class MyModel { //                                               <--- MyModel
  MyModel({this.someValue});
  String someValue = 'Hello';
  Future<void> doSomething() async {
    await Future.delayed(Duration(seconds: 2));
    someValue = 'Goodbye';
    print(someValue);
  }
}

Future<MyModel> someAsyncFunctionToGetMyModel() async { //  <--- async function
  await Future.delayed(Duration(seconds: 3));
  return MyModel(someValue: 'new data');
}