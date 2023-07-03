import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Task model to get parameters
class Task {
  User? user = FirebaseAuth.instance.currentUser;

  String? id;
  String title;
  String description;
  String? location;
  String time;
  String image;
  FieldValue? createdOn;

  Task(
      {this.id,
      required this.title,
      required this.description,
      required this.time,
      this.location,
      required this.image,
      this.createdOn});

//Convert document data to model
  factory Task.fromSnapshot(DocumentSnapshot<Object?> document) {
    final data = (document.data()! as dynamic);

    return Task(
        id: document.id,
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        time: data['time'],
        location: data['location'] ?? '',
        image: data['taskImage_url'] ?? '');
  }

  //Convert Model to JSON
  Map<String, dynamic> toJson(){
    return {
      'title': title,
      'description': description,
      'time': time,
      'location': location,
      'taskImage_url': image,
      'createdOn': createdOn
    };
  }
}
