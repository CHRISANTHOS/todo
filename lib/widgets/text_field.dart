import 'package:flutter/material.dart';

Widget textField({required String text, String? hint, required TextEditingController controller, int? maxLines = 1}){
  return Column(
    children: [
      Container(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black54
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffF5F5F5)
        ),
        child: TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(hintText: hint, border: InputBorder.none),
        ),
      )
    ],
  );
}