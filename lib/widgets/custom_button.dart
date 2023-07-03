import 'package:flutter/material.dart';


//Return custom button as a widget

Widget customButton({required String text, required VoidCallback? onTap, Color? bgColor, Color? textColor}){
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    child: Material(
      elevation: 5.0,
      color: bgColor ?? Colors.transparent,
      borderRadius: BorderRadius.circular(30.0),
      child: MaterialButton(
        onPressed: onTap,
        minWidth: 200.0,
        height: 42.0,
        child: Text(
          text,
          style: TextStyle(color: textColor ?? Colors.white),
        ),
      ),
    ),
  );
}