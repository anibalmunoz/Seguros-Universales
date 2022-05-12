import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final TextEditingController _textEditingController;
  final String label;

  TextBox(this._textEditingController, this.label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: TextField(
        //controller: _textEditingController,
        decoration: InputDecoration(
            filled: true,
            labelText: label,
            suffix: GestureDetector(
              child: Icon(Icons.close),
              // onTap: () {
              //   _textEditingController.clear();
              // },
            )),
      ),
    );
  }
}
