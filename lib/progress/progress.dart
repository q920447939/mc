import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  final BuildContext context;
  double value;

  ProgressDialog(this.context, {this.value = 0});

  void close() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        value: value,
      ),
    );
  }
}
