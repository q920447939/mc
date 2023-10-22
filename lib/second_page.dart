import 'package:flutter/cupertino.dart';
import 'package:mc/main.dart';

class SecondPage extends StatelessWidget {
  final String params;
  const SecondPage({super.key, this.params = ''});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('SecondPage Params is : $params');
        var result = 'ack from secondPage';
        router.popRoute(params: result);
      },
      child: Text('第二个页面'),
    );
  }
}
