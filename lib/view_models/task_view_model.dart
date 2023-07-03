import 'package:todo_uchenna/model/task.dart';

//Set TaskViewModel class as a getter for the model

class TaskViewModel{

  Task task;
  TaskViewModel({required this.task});

  String? get id{
    return task.id;
  }

  String get title{
    return task.title;
  }

  String get description{
    return task.description;
  }

  String get time{
    return task.time;
  }

  String? get location{
    return task.location;
  }

  String get image{
    return task.image;
  }



}