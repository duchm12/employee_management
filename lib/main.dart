import 'package:flutter/material.dart';

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

class HomeRoute extends StatelessWidget {
  const HomeRoute({Key? key}) : super(key: key);

  Widget _buildCardItem(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              leading: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: const CircleAvatar(
                  backgroundColor: Colors.purple,
                  child: Text('D'),
                ),
              ),
              title: const Text('Hoang Minh Duc'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Age: 21'),
                  const Text('Salary: 0'),
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
            InfoHeader(),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (_, index) => _buildCardItem(context),
              ),
            ),
          ],
        ),
      ),
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
        const HeaderCard(title: 'Total', content: '0'),
        const HeaderCard(title: 'Oldest', content: 'Hoang Minh Duc'),
      ],
    );
  }
}

class FormRoute extends StatelessWidget {
  FormRoute({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

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
                      decoration: InputDecoration(
                          icon: const Icon(Icons.person), hintText: 'Name *'),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(
                          icon: const Icon(Icons.contact_page),
                          hintText: 'Age *'),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(
                          icon: const Icon(Icons.money), hintText: 'Salary *'),
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
                        Navigator.pop(context);
                      },
                      child: const Text('ADD'),
                    ),
                  ),
                  SizedBox(
                    width: 200.0,
                    child: ElevatedButton(
                      onPressed: () {
                        _promptUserDeleteConfirmation(context);
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
