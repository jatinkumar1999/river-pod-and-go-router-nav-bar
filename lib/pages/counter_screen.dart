import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pods_practice/main.dart';

import 'get_users/get_user_controllers.dart';

class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final counter = ref.watch(counterProvider);
    final getUserFutureAwait = ref.watch(getUserFuture);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Page'),
      ),
      body: getUserFutureAwait.when(
        data: (data) {
          // log(data.toString());
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ' counter.toString()',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ],
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (_, __) => Container(
          color: Colors.green,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(counterProvider.notifier).state++;
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
