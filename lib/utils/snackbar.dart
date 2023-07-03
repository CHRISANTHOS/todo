import 'package:flutter/material.dart';

//Return snack-bar
void showSnackBar(BuildContext context, String message){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}