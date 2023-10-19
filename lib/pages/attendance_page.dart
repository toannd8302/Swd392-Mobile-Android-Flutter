import 'package:flutter/material.dart';


class attContentPage extends StatefulWidget {
  const attContentPage({super.key});

  @override
  State<attContentPage> createState() => _attContentPageState();
}

class _attContentPageState extends State<attContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lịch công việc'),
        
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            
          ],
        ),
      ),
    );
  }
  }
