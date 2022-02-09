import 'package:employee_management/data.dart';
import 'package:mobx/mobx.dart';
import 'package:employee_management/employee.dart';

part 'employee_store.g.dart';

class EmployeeStore = _EmployeeStore with _$EmployeeStore;

abstract class _EmployeeStore with Store {
  var employeeList = ObservableList<Employee>.of(data);

  @action
  void addEmployee(Employee e) {
    employeeList.add(e);
  }

  @action
  void removeEmployee(Employee e) {
    employeeList.removeWhere(
        (employee) => employee.id == e.id); // Don't know, test it out!
  }

  @action
  void updateEmployee(Employee employee) {
    int index = employeeList.indexWhere((e) => e.id == employee.id);
    employeeList[index] = employee; // Do you have to do this?
  }

  @computed
  String get totalSalary {
    int sum = 0;
    for (var employee in employeeList) {
      sum += employee.salary;
    }
    return sum.toString();
  }

  @computed
  String get oldestEmployee {
    int index = -1;
    int highestAge = 0;
    for (var e in employeeList) {
      if (e.age > highestAge) {
        highestAge = e.age;
        index++;
      }
    }
    return employeeList[index].lastName + ' ' + employeeList[index].firstName;
  }
}
