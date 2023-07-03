import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_uchenna/model/task.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_uchenna/view_models/task_view_model.dart';

class TaskListView extends ChangeNotifier{
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  Stream<List<TaskViewModel>> getTasks() {
    return _fireStore
        .collection('AllTasks')
        .doc(user?.uid)
        .collection('Tasks')
        .orderBy('createdOn', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) {
            return Task.fromSnapshot(doc);
          })
          .toList()
          .map((task) {
            return TaskViewModel(task: task);
          })
          .toList();
    });
  }

  Stream<List<TaskViewModel>> getSearchedTasks(String search) {
    return _fireStore
        .collection('AllTasks')
        .doc(user?.uid)
        .collection('Tasks')
        .where('title', isEqualTo: search)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) {
            return Task.fromSnapshot(doc);
          })
          .toList()
          .map((task) {
            return TaskViewModel(task: task);
          })
          .toList();
    });
  }

}
