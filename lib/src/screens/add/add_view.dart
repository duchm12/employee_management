import 'package:flutter/material.dart';

import 'add_viewmodel.dart';

final AddViewModel vm = AddViewModel();

class AddRoute extends StatefulWidget {
  const AddRoute({Key? key}) : super(key: key);

  @override
  State<AddRoute> createState() => _AddRouteState();
}

class _AddRouteState extends State<AddRoute> {


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add employee'),
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
              ElevatedButton(
                // This is bad!
                onPressed: () => vm.validateAndSubmit(context),
                child: const Text('ADD'),
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
