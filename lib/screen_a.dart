import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:method_channel_example/main.dart';

class ScreenA extends StatelessWidget {
  const ScreenA({super.key});

  void showPopUp({required Function() okFuc, required BuildContext ctx}) async {
    await showDialog(
      context: ctx,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("App pop up"),
          content: Text("TEst App Pop up."),
          actions: [
            TextButton(child: Text("OK"), onPressed: okFuc),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Screen A"),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/screen_b');
                route.add('/screen_b');
              },
              child: const Text('Go To B'),
            ),
            ElevatedButton(
              onPressed: () async {
                showPopUp(
                  ctx: context,
                  okFuc: () {},
                );
              },
              child: const Text('show pop up'),
            )
          ],
        ),
      ),
    );
  }
}
