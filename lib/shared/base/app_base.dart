import 'package:flutter/material.dart';

class AppBase extends StatelessWidget {
  final Widget child;
  final String? title;
  final FloatingActionButton? action;

  const AppBase({super.key, this.title, this.action, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (title != null) ? AppBar(title: Text(title ?? '')) : null,
      body: SafeArea(child: child),
      floatingActionButton: action,
    );
  }
}
