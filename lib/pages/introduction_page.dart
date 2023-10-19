import 'package:flutter/material.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Introduction'),
      ),
      body: Container(
        child: Text("Hello We are IC Company"),
      ),
    );
  }
}