import 'package:flutter/material.dart';
import 'package:mc/MCRouter.dart';
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

  final PageController _pageController = PageController(initialPage: 0);
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blueAccent;
  int _currentIndex = 0;

  void _incrementCounter() async {
    print('Start second Page');
    var ack = await router.push(
        name: MCRouter.videoListPage, arguments: 'Hello from mainPage');
    print('ack : $ack');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          //MinePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          router.replace(name: MCRouter.miniPage);
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _defaultColor,
            ),
            activeIcon: Icon(
              Icons.home,
              color: _activeColor,
            ),
            label: '首页',
            tooltip: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: _defaultColor,
            ),
            activeIcon: Icon(
              Icons.search,
              color: _activeColor,
            ),
            label: '搜索',
          ),
        ],
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
