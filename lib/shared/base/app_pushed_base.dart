import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppPushedBase extends StatelessWidget {
  final String title;
  final Widget child;
  const AppPushedBase({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),

      body: SafeArea(child: child),
    );
  }
}
