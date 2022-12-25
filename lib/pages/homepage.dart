import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static String routeName = '/next';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Done')),
    );
  }
}
