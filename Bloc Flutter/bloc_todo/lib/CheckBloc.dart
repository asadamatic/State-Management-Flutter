import 'dart:async';

class CheckBloc{
  bool status = false;

  final _statusStreamController = StreamController<bool>();
  final _statusChangeStreamController = StreamController<bool>();

  Stream<bool> get statusStream => _statusStreamController.stream;
  StreamSink<bool> get statusSink => _statusStreamController.sink;

  StreamSink<bool> get statusChangeSink => _statusChangeStreamController.sink;
  CheckBloc(){
    _statusStreamController.add(status);
    _statusChangeStreamController.stream.listen(_changeStatus);
  }

  void _changeStatus(bool event) {
    event = !event;
    status = event;
    statusSink.add(status);
  }

  void dispose(){
    _statusStreamController.close();
    _statusChangeStreamController.close();
  }
}