import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:method_channel_example/screen_a.dart';
import 'package:method_channel_example/screen_b.dart';

void main() {
  runApp(const MyApp());
}

List<String> route = ['/'];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
        '/screen_a': (context) => const ScreenA(),
        '/screen_b': (context) => const ScreenB(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  String _data = 'no data';

  final MethodChannel channel = const MethodChannel('flutter_channel');

  void backBtnChannel() {
    channel.setMethodCallHandler((call) async {
      final argument = call.arguments;
      switch (call.method) {
        case "BackBtn":
          screenNavigationFunction();
          break;
        default:
          break;
      }
    });
  }

  void screenNavigationFunction() async {
    if (route.isNotEmpty) {
      route.forEach((ele) {
        print("routes$ele");
      });
    }
    switch (route.last) {
      case '/':
        if (route.length == 1 && route.last == '/') {
          route = ['/goToBackGround'];
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Press back again to exit"),
            ),
          );
        } else {
          route.removeLast();
          Navigator.pushNamed(context, route.last);
        }

        break;
      case '/screen_a':
        route.removeLast();
        Navigator.pushNamed(context, route.last);

        break;

      case '/screen_b':
        route.removeLast();
        Navigator.pushNamed(context, route.last);
        break;
      case '/goToBackGround':
        await channel.invokeMethod('moveToBackground');
    }
  }

  @override
  void initState() {
    super.initState();
    backBtnChannel();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (route.contains('/goToBackGround')) {
          route = ['/'];
        }
        break;
      case AppLifecycleState.inactive:
        if (route.contains('/goToBackGround')) {
          route = ['/'];
        }
        break;
      case AppLifecycleState.paused:
        if (route.contains('/goToBackGround')) {
          route = ['/'];
        }
        break;
      case AppLifecycleState.detached:
        if (route.contains('/goToBackGround')) {
          route = ['/'];
        }
        break;
      case AppLifecycleState.hidden:
        if (route.contains('/goToBackGround')) {
          route = ['/'];
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/screen_a');

                  route.add('/screen_a');
                },
                child: const Text('Go TO Screen A')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/screen_b');

                  route.add('/screen_b');
                },
                child: const Text('Go TO Screen B')),
            ElevatedButton(
                onPressed: () async {
                  var __data =
                      await channel.invokeMethod<String>('functionFromKotlin');
                  print(__data);
                  _data = __data.toString();
                  setState(() {});
                },
                child: const Text("call fun")),
            Text((_data).toString())
          ],
        ),
      ),
    );
  }
}
