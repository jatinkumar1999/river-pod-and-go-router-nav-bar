import 'dart:developer';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class TextIsolatesScreen extends StatelessWidget {
  const TextIsolatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/Animation - 1720339667419.json'),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                int total = setLoopValues();

                log(total.toString());
              },
              child: const Text(
                'Task 1',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () async {
                var afterHittingIsolates = await Isolate.run(() {
                  return setLoopValues();
                });

                log(afterHittingIsolates.toString());
              },
              child: const Text(
                'Task 2',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () async {
                final receiverPort = ReceivePort();
                await Isolate.spawn(setLoopValues2, receiverPort.sendPort);
                receiverPort.listen((total) {
                  log('totaltotal==>>$total');
                });
                // log(afterHittingIsolates.toString());
              },
              child: const Text(
                'Task 3',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

int setLoopValues() {
  int total = 0;

  for (var i = 0; i < 20000000000; i++) {
    total += i;
  }

  return total;
}

setLoopValues2(SendPort port) {
  int total = 0;

  for (var i = 0; i < 20000000000; i++) {
    total += i;
  }
  port.send(total);
  // return total;
}
