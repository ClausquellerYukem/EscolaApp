import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TenantSelectorPage extends StatefulWidget {
  const TenantSelectorPage({super.key});

  @override
  State<TenantSelectorPage> createState() => _TenantSelectorPageState();
}

class _TenantSelectorPageState extends State<TenantSelectorPage> {
  final _tenantIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select School')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _tenantIdController,
              decoration: const InputDecoration(
                labelText: 'School Code',
                hintText: 'Enter your school code',
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                final tenantId = _tenantIdController.text;
                if (tenantId.isNotEmpty) {
                  context.go('/login', extra: tenantId);
                }
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
