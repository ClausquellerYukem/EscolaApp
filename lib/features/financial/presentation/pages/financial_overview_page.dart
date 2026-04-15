import 'package:flutter/material.dart';

class FinancialOverviewPage extends StatelessWidget {
  const FinancialOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Financial Overview')),
      body: const Center(child: Text('Financial Dashboard')),
    );
  }
}
