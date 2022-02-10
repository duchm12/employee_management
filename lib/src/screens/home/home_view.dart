import 'package:employee_management/src/helper/utils.dart';
import 'package:employee_management/src/screens/add/add_view.dart';
import 'package:employee_management/src/screens/edit/edit_view.dart';
import 'package:employee_management/src/screens/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

final HomeViewModel vm = HomeViewModel();

class HomeRoute extends StatelessWidget {
  const HomeRoute({Key? key}) : super(key: key);

  Widget _buildCardItem(BuildContext context, int index) {
    var current = vm.employeeList[index];
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
                title: Text(Utils.truncateLongString(
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
              onPressed: () =>
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditRoute(currentId: current.id))),
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
                    itemCount: vm.employeeList.length,
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
        onPressed: () =>
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const AddRoute())),
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
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
                HeaderCard(title: 'Total', content: vm.totalSalary)),
        Observer(
            builder: (_) => HeaderCard(
                title: 'Total', content: vm.oldestEmployee)),
      ],
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