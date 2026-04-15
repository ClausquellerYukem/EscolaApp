import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StudentSelectorPage extends StatelessWidget {
  const StudentSelectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Student')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('John Doe'),
            onTap: () {
              context.go('/dashboard');
            },
          ),
          ListTile(
            title: const Text('Jane Doe'),
            onTap: () {
              context.go('/dashboard');
            },
          )
        ],
      ),
    );
  }
}
