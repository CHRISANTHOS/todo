import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_uchenna/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:todo_uchenna/view_models/add_task_view_model.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AddTaskViewModel(),
      child: const MaterialApp(
        home: SplashScreen(),
      ),
    );
  }
}

