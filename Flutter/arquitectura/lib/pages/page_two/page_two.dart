import 'package:flutter/material.dart';

class PageTwo extends StatelessWidget {
  final String title;
  const PageTwo({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(this.title),
      ),
    );
  }
}
