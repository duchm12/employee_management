import 'package:employee_management/src/repository/data.dart';
import 'package:mobx/mobx.dart';
import 'package:employee_management/src/models/employee.dart';

part 'employee_store.g.dart';

class EmployeeStore = _EmployeeStore with _$EmployeeStore;

abstract class _EmployeeStore with Store {
  var employeeList = ObservableList<Employee>.of(data);

  @computed
  int get lastestId => employeeList.last.id;

  @action
  void addEmployee(Employee e) {
    employeeList.add(e);
  }

  @action
  void removeEmployee(int id) {
    employeeList.removeWhere(
        (employee) => employee.id == id); // Don't know, test it out!
  }

  @action
  void updateEmployee(Employee employee) {
    int index = employeeList.indexWhere((e) => e.id == employee.id);
    employeeList[index] = employee; // Do you have to do this?
  }
}
