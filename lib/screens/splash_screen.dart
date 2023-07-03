import 'package:flutter/material.dart';
import 'package:todo_uchenna/utils/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_uchenna/screens/home_screen.dart';
import 'package:todo_uchenna/screens/authentication/auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), (){
      if(firebaseAuth.currentUser != null){
        nextPageReplace(const HomeScreen(), context);
      }else{
        nextPageReplace(const AuthScreen(), context);
      }
    });

    return const Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 50,
        ),
      ),
    );
  }
}
