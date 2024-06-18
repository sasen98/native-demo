import 'package:flutter/material.dart';
import 'package:method_channel_example/main.dart';

class ScreenB extends StatelessWidget {
  const ScreenB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Screen B"),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/screen_a');
                  route.add('/screen_a');
                },
                child: const Text('Go To A'))
          ],
        ),
      ),
    );
  }
}
