import 'package:flutter/material.dart';

class MarkAttendancePage extends StatelessWidget {
  const MarkAttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mark Attendance')),
      body: const Center(child: Text('Teacher Attendance Screen')),
    );
  }
}
