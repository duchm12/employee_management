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

  Widget _buildCardItem() {
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
            onPressed: () {},
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
                itemBuilder: (_, index) => _buildCardItem(),
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
        HeaderCard(title: 'Total', content: '0'),
        HeaderCard(title: 'Oldest', content: 'Hoang Minh Duc'),
      ],
    );
  }
}
