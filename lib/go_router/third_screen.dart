import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.push(
              "/",
            );
          },
          child: const Text(
            'First Screen',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
