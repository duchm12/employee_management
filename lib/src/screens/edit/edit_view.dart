import 'package:employee_management/src/screens/edit/edit_viewmodel.dart';
import 'package:flutter/material.dart';

final EditViewModel vm = EditViewModel();

class EditRoute extends StatefulWidget {
  EditRoute({required this.currentId});

  final int currentId;

  @override
  State<EditRoute> createState() => _EditRouteState();
}

class _EditRouteState extends State<EditRoute> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit employee'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>
            Navigator.pop(context),
        ),
      ),
      body: Form(
        key: vm.formKey,
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20.0),
                    TextFormField(
                      validator: vm.validateName,
                      controller: vm.fNameController,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.person), hintText: 'First name*'),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      validator: vm.validateName,
                      controller: vm.lNameController,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.person), hintText: 'Last name*'),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                        validator: vm.validateNum,
                        controller: vm.bDateController,
                        decoration: const InputDecoration(
                            icon: Icon(Icons.contact_page),
                            hintText: 'Birth year*')),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      validator: vm.validateNum,
                      controller: vm.salaryController,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.money), hintText: 'Salary*'),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    // This is bad!
                    onPressed: () => vm.validateAndSubmit(context, widget.currentId),
                    child: const Text('UPDATE'),
                  ),
                  ElevatedButton(
                    onPressed: () => vm.toggleDeleteDialog(context, widget.currentId), // I sense danger
                    child: const Text('DELETE'),
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
