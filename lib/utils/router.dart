import 'package:flutter/material.dart';

void nextPage(Widget page, BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (_) => page));
}

void nextPageReplace(Widget page, BuildContext context){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
}