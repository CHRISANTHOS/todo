import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:flutter/material.dart';
import 'package:todo_uchenna/model/task.dart';

class AddTaskViewModel extends ChangeNotifier {
  String _message = '';
  String imagePath = '';
  bool _loading = false;

  String get message => _message;
  bool get loading => _loading;

  final storage.FirebaseStorage _storage = storage.FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Reset snack-bar message
  void resetMessage() {
    _message = '';
    notifyListeners();
  }

  //Add new task to fireStore
  Future<void> addTask(
      {File? taskImage,
      String? uid,
      String? title,
      String? description,
      String? time,
      String? location}) async {
    _loading = true;
    notifyListeners();

    CollectionReference _products = _firestore
        .collection('AllTasks')
        .doc(uid)
        .collection('Tasks');

    try {
      _message = 'Uploading Task..';
      notifyListeners();

      final imageName = taskImage!.path.split('/').last;
      await _storage
          .ref()
          .child('$uid/Tasks/$imageName')
          .putFile(taskImage)
          .whenComplete(() async {
        await _storage
            .ref()
            .child('$uid/Tasks/$imageName')
            .getDownloadURL()
            .then((value) {
          imagePath = value;
        });
      });

      final data = Task(
        title: title!,
        description: description!,
        time: time!,
        image: taskImage.path,
        location: location,
        createdOn: FieldValue.serverTimestamp(),
      );

      await _products.add(data.toJson()); //Add Task model after converting to json

      _loading = false;
      _message = 'Success';
      notifyListeners();
    } on FirebaseException catch (e) {
      _loading = false;
      _message = e.message.toString();
      notifyListeners();
    } on SocketException catch (e) {
      print(e);
      _loading = false;
      _message = 'No internet connection';
      notifyListeners();
    } catch (e) {
      print(e);
      _loading = false;
      _message = 'Please try again';
      notifyListeners();
    }
  }

  //Update existing tasks on fireStore
  Future<void> updateTask(
      {required String docId,
      File? taskImage,
      String? uid,
      String? title,
      String? description,
      String? time,
      String? location}) async {
    _loading = true;
    notifyListeners();

    DocumentReference products = _firestore
        .collection('AllTasks')
        .doc(uid)
        .collection('Tasks')
        .doc(docId);

    try {
      _message = 'Updating Task..';
      notifyListeners();

      final imageName = taskImage!.path.split('/').last;
      await _storage
          .ref()
          .child('$uid/Tasks/$imageName')
          .putFile(taskImage)
          .whenComplete(() async {
        await _storage
            .ref()
            .child('$uid/Tasks/$imageName')
            .getDownloadURL()
            .then((value) {
          imagePath = value;
        });
      });

      final data = Task(title: title!, description: description!, time: time!, image: taskImage.path, location: location);

      await products.update(data.toJson()); //Update Task model

      _loading = false;
      _message = 'Success';
      notifyListeners();
    } on FirebaseException catch (e) {
      _loading = false;
      _message = e.message.toString();
      notifyListeners();
    } on SocketException catch (e) {
      print(e);
      _loading = false;
      _message = 'No internet connection';
      notifyListeners();
    } catch (e) {
      print(e);
      _loading = false;
      _message = 'Please try again';
      notifyListeners();
    }
  }

  //Delete tasks
  Future<void> deleteTask({required String docId, required String uid}) async {
    CollectionReference _products = _firestore.collection('AllTasks');

    try {
      _message = 'Deleting Task..';
      notifyListeners();

      await _products.doc(uid).collection('Tasks').doc(docId).delete();

      _message = 'Deleted';
      notifyListeners();
    } on FirebaseException catch (e) {
      _loading = false;
      _message = e.message.toString();
      notifyListeners();
    } on SocketException catch (e) {
      print(e);
      _loading = false;
      _message = 'No internet connection';
      notifyListeners();
    } catch (e) {
      print(e);
      _loading = false;
      _message = 'Please try again';
      notifyListeners();
    }
  }
}
