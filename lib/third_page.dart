import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    //CircularProgressIndicator不具备设置高度的选项，可以使用SizedBox来设置高度与宽度
    return Center(
      child: CircularProgressIndicator(
        value: 0.5,
      ),
    );
  }
}
