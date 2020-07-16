import 'dart:async';
import 'EmployeeData.dart';

class EmployeeBloc{

  //sink to add in pipe
  //stream to get data from sink
  List<EmployeeData> _employeeList = [
    EmployeeData(1, 'First', 10000.0),
    EmployeeData(2, 'Second', 20000.0),
    EmployeeData(3, 'Third', 30000.0),
  ];

  final _employeeListStreamController = StreamController<List<EmployeeData>>();
  final _employeeSalaryIncrementStreamController = StreamController<EmployeeData>();
  final _employeeSalaryDecrementStreamController = StreamController<EmployeeData>();

  Stream<List<EmployeeData>> get employeeListStream => _employeeListStreamController.stream;
  StreamSink<List<EmployeeData>> get employeeListStreamSink => _employeeListStreamController.sink;

  StreamSink<EmployeeData> get employeeSalaryIncrementSink => _employeeSalaryIncrementStreamController.sink;
  StreamSink<EmployeeData> get employeeSalaryDecrementSink => _employeeSalaryDecrementStreamController.sink;

  EmployeeBloc(){
    _employeeListStreamController.add(_employeeList);
    _employeeSalaryIncrementStreamController.stream.listen(_incrementSalary);
    _employeeSalaryDecrementStreamController.stream.listen(_decrementSalary);
  }

  _incrementSalary(EmployeeData employeeData){
    double salary = employeeData.salary;

    double incrementedSalary = salary * 20/100;

    _employeeList[employeeData.id - 1].salary = salary + incrementedSalary;

    employeeListStreamSink.add(_employeeList);
  }

  _decrementSalary(EmployeeData employeeData){
    double salary = employeeData.salary;

    double decrementedSalary = salary * 20/100;

    _employeeList[employeeData.id - 1].salary = salary - decrementedSalary;

    employeeListStreamSink.add(_employeeList);
  }
  
  void dispose(){
    _employeeListStreamController.close();
    _employeeSalaryIncrementStreamController.close();
    _employeeSalaryDecrementStreamController.close();
  }
}