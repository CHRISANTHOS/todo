import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_uchenna/widgets/text_field.dart';
import 'package:todo_uchenna/widgets/time_picker.dart';
import 'package:todo_uchenna/utils/pick_image.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:todo_uchenna/view_models/add_task_view_model.dart';
import '../utils/snackbar.dart';
import '../widgets/custom_button.dart';


class AddTaskScreen extends StatefulWidget {
  String address; //Address parameter
  AddTaskScreen({Key? key, required this.address}) : super(key: key); //Constructor

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {

  //TextControllers to get user texts
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _time = TextEditingController();
  final TextEditingController _location = TextEditingController();
  String imagePath = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _location.text = widget.address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Task'),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  textField(text: 'Enter title', controller: _title),
                  const SizedBox(
                    height: 20,
                  ),
                  textField(
                      text: 'Enter description',
                      controller: _description,
                      maxLines: null),
                  const SizedBox(
                    height: 20,
                  ),
                  TimePicker(controller: _time),
                  const SizedBox(
                    height: 20,
                  ),
                  textField(text: 'Current location', controller: _location),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      pickImage().then((value) {
                        setState(() {
                          imagePath = value;
                        });
                      });
                    },
                    child: const SizedBox(
                      height: 50,
                      width: 50,
                      child: Icon(Icons.camera),
                    ),
                  ),
                  if (imagePath != '') Image.file(File(imagePath)),
                  Consumer<AddTaskViewModel>(builder: (context, add, child) { //Consumer to monitor added tasks
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (add.message != '') {
                        showSnackBar(context, add.message);
                        add.resetMessage();
                      }
                    });

                    return customButton(
                        text: add.loading ? 'Uploading...' : 'Upload',
                        onTap: add.loading
                            ? null
                            : () async {
                          if (imagePath != '') {
                            await add.addTask(
                                uid: FirebaseAuth
                                    .instance.currentUser?.uid,
                                taskImage: File(imagePath),
                                title: _title.text ?? '',
                                description: _description.text ?? '',
                                time: _time.text ?? '',
                                location: _location.text ?? '');
                            Navigator.pop(context);
                          } else {
                            showSnackBar(context, 'Upload Image');
                          }
                        },
                        bgColor: add.loading ? Colors.grey : Colors.black54,
                        textColor: Colors.white);
                  })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}