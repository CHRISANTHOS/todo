import 'package:flutter/material.dart';

//Decoration constant for text field

const textFieldDecoration = InputDecoration(
    hintStyle: TextStyle(
        color: Colors.grey
    ),
    contentPadding:
    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    filled: true,
    fillColor: Colors.black26
);
