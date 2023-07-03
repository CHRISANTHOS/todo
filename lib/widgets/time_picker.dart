import 'package:flutter/material.dart';
import 'package:todo_uchenna/utils/snackbar.dart';


class TimePicker extends StatefulWidget {
  TextEditingController controller;

  TimePicker({Key? key, required this.controller}) : super(key: key);

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xffF5F5F5)),
      child: TextField(
        controller: widget.controller,
        decoration: const InputDecoration(
          hintText: 'Select time',
          border: InputBorder.none,
          icon: Icon(Icons.timer),
        ),
        readOnly: true,
        onTap: ()async{
          TimeOfDay? pickedTime =  await showTimePicker(
            initialTime: TimeOfDay.now(),
            context: context,
          );
          if(pickedTime != null ){
            String formattedTime = pickedTime.format(context).toString(); //output picked time

            setState(() {
              widget.controller.text = formattedTime; //set the value of text field.
            });
          }else{
            showSnackBar(context, 'Time is not selected');
          }
        },
      ),
    );
  }
}