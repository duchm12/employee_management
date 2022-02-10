import 'package:employee_management/src/models/employee.dart';
import 'package:employee_management/src/store/employee_store.dart';
import 'package:mobx/mobx.dart';

part 'home_viewmodel.g.dart';

class HomeViewModel = _HomeViewModel with _$HomeViewModel;

abstract class _HomeViewModel with Store{
  final EmployeeStore store = EmployeeStore();

  List<Employee> get employeeList => store.employeeList;

  @computed
  String get totalSalary {
    int sum = 0;
    for (var employee in store.employeeList) {
      sum += employee.salary;
      // sum = store.employeeList<Employee>.fold(0, (prev, element) => prev.salary + element.salary);
    }
    return sum.toString();
  }

  @computed
  String get oldestEmployee {
    int index = -1;
    int highestAge = 0;
    for (var e in store.employeeList) {
      if (e.age > highestAge) {
        highestAge = e.age;
        index++;
      }
    }
    return store.employeeList[index].lastName + ' ' + store.employeeList[index].firstName;
  }


}