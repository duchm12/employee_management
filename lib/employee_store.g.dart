// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EmployeeStore on _EmployeeStore, Store {
  Computed<String>? _$totalSalaryComputed;

  @override
  String get totalSalary =>
      (_$totalSalaryComputed ??= Computed<String>(() => super.totalSalary,
              name: '_EmployeeStore.totalSalary'))
          .value;
  Computed<String>? _$oldestEmployeeComputed;

  @override
  String get oldestEmployee =>
      (_$oldestEmployeeComputed ??= Computed<String>(() => super.oldestEmployee,
              name: '_EmployeeStore.oldestEmployee'))
          .value;

  final _$_EmployeeStoreActionController =
      ActionController(name: '_EmployeeStore');

  @override
  void addEmployee(Employee e) {
    final _$actionInfo = _$_EmployeeStoreActionController.startAction(
        name: '_EmployeeStore.addEmployee');
    try {
      return super.addEmployee(e);
    } finally {
      _$_EmployeeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeEmployee(Employee e) {
    final _$actionInfo = _$_EmployeeStoreActionController.startAction(
        name: '_EmployeeStore.removeEmployee');
    try {
      return super.removeEmployee(e);
    } finally {
      _$_EmployeeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateEmployee(Employee employee) {
    final _$actionInfo = _$_EmployeeStoreActionController.startAction(
        name: '_EmployeeStore.updateEmployee');
    try {
      return super.updateEmployee(employee);
    } finally {
      _$_EmployeeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
totalSalary: ${totalSalary},
oldestEmployee: ${oldestEmployee}
    ''';
  }
}
