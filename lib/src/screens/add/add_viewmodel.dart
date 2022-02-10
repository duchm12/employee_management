import 'package:employee_management/src/helper/utils.dart';
import 'package:employee_management/src/models/employee.dart';
import 'package:employee_management/src/store/employee_store.dart';
import 'package:flutter/material.dart';

class AddViewModel {
  final EmployeeStore store = EmployeeStore();

  final _formKey = GlobalKey<FormState>();
  // Repeat from edit? Not good?
  GlobalKey<FormState> get formKey => _formKey;

  final _fNameController = TextEditingController();

  TextEditingController get fNameController => _fNameController;

  final _lNameController = TextEditingController();

  TextEditingController get lNameController => _lNameController;

  final _bDateController = TextEditingController();

  TextEditingController get bDateController => _bDateController;

  final _salaryController = TextEditingController();

  TextEditingController get salaryController => _salaryController;

  List<Employee> get employeeList => store.employeeList;

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

  void validateAndSubmit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      int nextId = store.lastestId + 1;
      store.updateEmployee(
        Employee(nextId, _fNameController.text,
          _lNameController.text,
          int.parse(_bDateController.text),
          int.parse(_salaryController.text),
        ),
      );
      Navigator.pop(context);
    }
  }
}