import 'package:flutter/material.dart';

//Navigate to next page
void nextPage(Widget page, BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (_) => page));
}

//Replace current page
void nextPageReplace(Widget page, BuildContext context){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
}