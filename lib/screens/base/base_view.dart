import 'package:flutter/material.dart';

class BaseView extends StatelessWidget {
  const BaseView({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.width,
        color: Colors.brown,
      ),
    );
  }
}
