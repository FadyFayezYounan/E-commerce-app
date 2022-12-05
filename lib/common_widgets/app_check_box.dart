import 'package:flutter/material.dart';

class AppCheckBox extends StatefulWidget {
  const AppCheckBox({
    Key? key,
  }) : super(key: key);

  @override
  _AppCheckBoxState createState() => _AppCheckBoxState();
}

class _AppCheckBoxState extends State<AppCheckBox> {
  bool value = false;
  void toggleCheckBoxState(){
    setState(() {
      value = !value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      onChanged: (bool? value) {
        toggleCheckBoxState();
      },
      value: value,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      side: BorderSide(
        color: Theme.of(context).accentColor.withOpacity(0.5),
      ),



    );
  }
}