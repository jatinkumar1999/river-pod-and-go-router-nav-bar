import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.push('/second_screen');
          },
          child: const Text(
            'Second Screen',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
