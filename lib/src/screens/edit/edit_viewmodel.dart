import 'package:employee_management/src/helper/utils.dart';
import 'package:employee_management/src/models/employee.dart';
import 'package:employee_management/src/store/employee_store.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'edit_viewmodel.g.dart';

class EditViewModel = _EditViewModel with _$EditViewModel;

abstract class _EditViewModel with Store {
  _EditViewModel() {
    reactions.add(reaction((_) => _firstName, (e) {}));
    reactions.add(reaction((_) => _lastName, (e) {}));
    reactions.add(reaction((_) => _birthdate, (e) {}));
    reactions.add(reaction((_) => _salary, (e) {}));
  }

  final List<ReactionDisposer> reactions = List.of([]);

  final EmployeeStore store = EmployeeStore();

  final _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  @observable
  String _firstName = '';
  @observable
  String _lastName = '';
  @observable
  String _birthdate = '';
  @observable
  String _salary = '';

  @action
  void setFirstName(String value) => _firstName = value;

  @action
  void setLastName(String value) => _lastName = value;

  @action
  void setBirthDate(String value) => _birthdate = value;

  @action
  void setSalary(String value) => _salary = value;

  void populateEmployeeDataOf(int id) {
    int current = store.employeeList.indexWhere((e) => e.id == id);
    Employee currentEmployee = store.employeeList[current];
    setFirstName(currentEmployee.firstName);
    setLastName(currentEmployee.lastName);
    setBirthDate(currentEmployee.birthdate.toString());
    setSalary(currentEmployee.salary.toString());
  }

  String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Name cannot leave empty';
    }
    return null;
  }

  String? validateNum(String? num) {
    if (num == null || num.isEmpty) {
      return 'Age cannot leave empty';
    }
    if (int.tryParse(num) == null) {
      return '$num is not an integer';
    }
    return null;
  }

  void toggleDeleteDialog(BuildContext context, int id) async {
    bool? result = await Utils.displayDialogOKCallback(
        context, "Warning", "Do you want to delete");
    if (result == true) {
      store.removeEmployee(id);
    }
  }

  void removeEmployee(int id) {
    store.removeEmployee(id);
  }

  void validateAndSubmit(BuildContext context, int id) {
    if (_formKey.currentState!.validate()) {
      store.updateEmployee(
        Employee(
          id,
          _firstName,
          _lastName,
          int.parse(_birthdate),
          int.parse(_salary),
        ),
      );
      Navigator.pop(context);
    }
  }

  void disposeReaction() {
    for (var reaction in reactions) {
      reaction();
    }
  }
}
