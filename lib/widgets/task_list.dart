import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_uchenna/view_models/task_list_view_model.dart';
import 'dart:io';
import 'package:todo_uchenna/screens/update_screen.dart';
import '../utils/router.dart';
import 'package:provider/provider.dart';
import '../view_models/add_task_view_model.dart';
import 'package:todo_uchenna/view_models/task_view_model.dart';

class TaskList extends StatefulWidget {

  TaskList({Key? key,required this.stream}) : super(key: key); //TaskList constructors to accept stream parameter
  Stream<List<TaskViewModel>>? stream; //Stream parameter

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  TaskListView viewModel = TaskListView();


  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser; //Get current user


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.stream,
      builder: (context, snapshot){
        if (!snapshot.hasData) { //Return No task if empty
          return const Center(
            child: Text(
              'No Tasks',
              style: TextStyle(color: Colors.black),
            ),
          );
        }
        if(snapshot.connectionState == ConnectionState.waiting){ //Return circular indicator while loading
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final tasks = snapshot.data;

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          itemCount: tasks!.length,
          itemBuilder: (context, index){

            final task = tasks[index];

            return Column(
              children: [
                ListTile( //Task ListTile
                  key: ValueKey(task),
                  leading: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: FileImage(File(task.image)))),
                  ),
                  title: Text(task.title),
                  subtitle: Text(task.description),
                  trailing: PopupMenuButton<String>( //Trailing button to get more actions
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Text('Edit'),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text('Delete'),
                        ),
                        // Add more PopupMenuItems as needed
                      ];
                    },
                    onSelected: (value) {
                      if(value == 'edit'){ //Navigate to Update Screen
                        nextPage(
                            UpdateTaskScreen(
                              title: task.title,
                              description: task.description,
                              oldImage: task.image,
                              time: task.time,
                              location: task.location!,
                              docId: task.id!,
                            ),
                            context);
                      }else if(value == 'delete'){ //Delete Task
                        Provider.of<AddTaskViewModel>(context, listen: false).deleteTask(docId: task.id!, uid: FirebaseAuth.instance.currentUser!.uid);
                      }
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    task.location != null ? 'set ${task.time} at ${task.location}' : 'set ${task.time}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black54),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
