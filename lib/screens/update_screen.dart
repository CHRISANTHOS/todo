import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_uchenna/widgets/text_field.dart';
import 'package:todo_uchenna/widgets/time_picker.dart';
import 'package:todo_uchenna/utils/pick_image.dart';
import 'dart:io';
import 'package:todo_uchenna/view_models/add_task_view_model.dart';
import 'package:todo_uchenna/widgets/custom_button.dart';
import 'package:todo_uchenna/utils/snackbar.dart';

class UpdateTaskScreen extends StatefulWidget {
  String title;
  String description;
  String time;
  String location;
  String oldImage;
  String docId;
  UpdateTaskScreen({Key? key, required this.title, required this.description, required this.oldImage, required this.time, required this.location, required this.docId}) : super(key: key);

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _time = TextEditingController();
  final TextEditingController _location = TextEditingController();
  String imagePath = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _title.text = widget.title;
    _description.text = widget.description;
    _location.text = widget.location;
    _time.text = widget.time;
    imagePath = widget.oldImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Task'),
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
                  Consumer<AddTaskViewModel>(builder: (context, add, child) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (add.message != '') {
                        showSnackBar(context, add.message);
                        add.resetMessage();
                      }
                    });

                    return customButton(
                        text: add.loading ? 'Updating...' : 'Update',
                        onTap: add.loading
                            ? null
                            : () async {
                          if (imagePath != '') {
                            await add.updateTask(
                                uid: FirebaseAuth
                                    .instance.currentUser?.uid,
                                taskImage: File(imagePath),
                                title: _title.text ?? '',
                                description: _description.text ?? '',
                                time: _time.text ?? '',
                                location: _location.text ?? '', docId: widget.docId);
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