import 'package:flutter/material.dart';
import 'package:mc/MCRouter.dart';
import 'package:mc/player_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:player/player.dart';

void main() {
  runApp(const MyApp());
  init();
}

String storagePath = '';

void init() {
  getApplicationSupportDirectory().then((directory) {
    storagePath = directory.path;
    Player.setCachePath(storagePath);
  });
}

MCRouter router = MCRouter();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Router(
        routerDelegate: router,
        backButtonDispatcher: RootBackButtonDispatcher(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() async {
    print('Start second Page');
    var ack = await router.push(
        name: MCRouter.videoListPage, arguments: 'Hello from mainPage');
    print('ack : $ack');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
