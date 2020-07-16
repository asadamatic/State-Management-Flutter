
import 'dart:async';

import 'package:bloc_sqlite/CustomDatabase.dart';

class StringBloc{

  String name;
  List<String> names;

  final _nameStreamController = StreamController<String>();
  final _insertNameStreamController = StreamController<String>();
  final _namesStreamController = StreamController<List<String>>();
  final _getNamesStreamController = StreamController<List<String>>();

  Stream<String> get nameStream => _nameStreamController.stream;
  StreamSink<String> get nameSink => _nameStreamController.sink;

  StreamSink<String> get insertNameSink => _insertNameStreamController.sink;

  Stream<List<String>> get namesStream => _namesStreamController.stream;
  StreamSink<List<String>> get namesSink => _namesStreamController.sink;

  StreamSink<List<String>> get getNamesSink => _getNamesStreamController.sink;


  StringBloc(){
    _nameStreamController.add(name);
    _insertNameStreamController.stream.listen(_insertNameIntoDb);
    _namesStreamController.add(names);
    _getNamesStreamController.stream.listen(_getNameList);
  }


  void _insertNameIntoDb(String value) {
    CustomDatabase.instance.insertData(value);

  }

  void dispose(){
    _nameStreamController.close();
    _insertNameStreamController.close();
  }

  void _getNameList(List<String> value) async{

    names = await CustomDatabase.instance.returnData();
    namesSink.add(names);
  }
}