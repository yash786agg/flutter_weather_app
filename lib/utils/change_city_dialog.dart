import 'package:flutter/material.dart';

class ChangeCityDialog extends StatelessWidget {
  ChangeCityDialog({@required this.onOkPressed}) : assert(onOkPressed != null);
  final Function onOkPressed;

  String _textFieldStr;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        'Change City',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () {
            print('on Pressed AlertDialog _textFieldStr: $_textFieldStr');
            onOkPressed(_textFieldStr);
            Navigator.pop(context);
          },
          child: Text(
            'Ok',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        )
      ],
      content: TextField(
        decoration: InputDecoration(
          fillColor: Color(0xFFF2F2F2),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: Colors.black),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: Colors.orange),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: Colors.green),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(
                width: 1,
              )),
          hintText: 'Enter the City Name',
          helperText: 'Keep it short, this is just a demo.',
          labelText: 'City Name',
          labelStyle: TextStyle(
            color: Colors.black,
          ),
        ),
        autofocus: true,
        onChanged: (text) {
          print('on Pressed AlertDialog text: $text');
          _textFieldStr = text;
        },
        style: TextStyle(color: Colors.black),
        cursorColor: Colors.black,
      ),
    );
  }
}
