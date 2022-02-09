import 'package:mobx/mobx.dart';

class Employee {
  Employee(this.id, this.firstName, this.lastName, this.birthdate, this.salary);

  int id;

  @observable
  String firstName;

  @observable
  String lastName;

  @observable
  int birthdate;

  @observable
  int salary;

  int get age => DateTime.now().year - birthdate;
}
