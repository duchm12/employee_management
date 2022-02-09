import 'package:employee_management/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'employee.dart';
import 'employee_store.dart';

final EmployeeStore employeeStore = EmployeeStore();

void main() {
  runApp(const ManagementApp());
}

class ManagementApp extends StatelessWidget {
  const ManagementApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomeRoute(),
    );
  }
}

String truncateLongString(String base, int limit) {
  return base.length > limit
      ? base.substring(0, limit - 1).toString() + '...'
      : base;
}

class HomeRoute extends StatelessWidget {
  const HomeRoute({Key? key}) : super(key: key);

  Widget _buildCardItem(BuildContext context, int index) {
    var current = employeeStore.employeeList[index];
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.purple,
                  child: Text(current.lastName[0]),
                ),
                title: Text(truncateLongString(
                    current.lastName + ' ' + current.firstName, 26)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Age: ${current.age.toString()}'),
                    Text('Salary: ${current.salary.toString()}'),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FormRoute()));
              },
              icon: const Icon(Icons.edit),
              iconSize: 14.0,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          children: [
            const InfoHeader(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Observer(
                  builder: (_) => ListView.builder(
                    itemCount: employeeStore.employeeList.length,
                    itemBuilder: (_, index) => _buildCardItem(
                      context,
                      index,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.purple,
        child: Container(height: 40.0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FormRoute()));
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

class HeaderCard extends StatelessWidget {
  const HeaderCard({Key? key, required this.title, required this.content})
      : super(key: key);

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(
          content,
          style: const TextStyle(fontSize: 18.0, height: 2.0),
        ),
      ),
    ));
  }
}

class InfoHeader extends StatelessWidget {
  const InfoHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Observer(
            builder: (_) =>
                HeaderCard(title: 'Total', content: employeeStore.totalSalary)),
        Observer(
            builder: (_) => HeaderCard(
                title: 'Total', content: employeeStore.oldestEmployee)),
      ],
    );
  }
}

class FormRoute extends StatefulWidget {
  const FormRoute({Key? key}) : super(key: key);

  @override
  State<FormRoute> createState() => _FormRouteState();
}

class _FormRouteState extends State<FormRoute> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _salaryController = TextEditingController();
  final _birthdateController = TextEditingController();

  Future<void> _promptUserDeleteConfirmation(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Warning'),
        content: Text('Do you want to delete this employee?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Accept');
              Navigator.pop(context);
            },
            child: Text('Accept'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit employee'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20.0),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'First name can not be empty';
                        }
                        return null;
                      },
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.person), hintText: 'First name*'),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Last name can not be empty';
                        }
                        return null;
                      },
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.person), hintText: 'Last name*'),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Birth date can not be empty';
                          }
                          if (int.tryParse(value) == null) {
                            return '$value is not an integer';
                          }
                          return null;
                        },
                        controller: _birthdateController,
                        decoration: const InputDecoration(
                            icon: Icon(Icons.contact_page),
                            hintText: 'Birth year*')),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Salary can not be empty';
                        }
                        if (int.tryParse(value) == null) {
                          return '$value is not an integer';
                        }
                        return null;
                      },
                      controller: _salaryController,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.money), hintText: 'Salary*'),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Column(
                children: [
                  SizedBox(
                    width: 200.0,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          employeeStore.addEmployee(
                            Employee(
                                10,
                                _firstNameController.text,
                                _lastNameController.text,
                                int.parse(_birthdateController.text),
                                int.parse(_salaryController.text)),
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('ADD'),
                    ),
                  ),
                  SizedBox(
                    width: 200.0,
                    child: ElevatedButton(
                      onPressed: () async {
                        bool? result =
                            await DialogUtils.displayDialogOKCallback(
                                context, "confirm", "CHECK");
                        if (result == true) {
                          print(result);
                        }
                        // _promptUserDeleteConfirmation(context);
                      },
                      child: const Text('DELETE'),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
