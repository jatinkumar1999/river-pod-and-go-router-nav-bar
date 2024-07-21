import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SecondsScreen extends StatelessWidget {
  const SecondsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.push('/third_screen');
          },
          child: const Text(
            'Third Screen',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
