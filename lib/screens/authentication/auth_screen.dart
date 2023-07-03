import 'package:flutter/material.dart';
import 'package:todo_uchenna/utils/snackbar.dart';
import 'package:todo_uchenna/utils/router.dart';
import 'package:todo_uchenna/screens/home_screen.dart';
import 'package:todo_uchenna/widgets/custom_button.dart';
import 'package:todo_uchenna/provider/auth_provider.dart';

//Authentication Screen

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: customButton(
              text: 'Continue with Google',
              onTap: () {
                AuthProvider().signInWithGoogle().then((value) {
                  nextPageReplace(const HomeScreen(), context); //Navigate to Home Screen after authentication success
                }).catchError((e){
                  print(e);
                  showSnackBar(context, e.toString(),); //Show Possible error
                });
              },
              bgColor: Colors.black54,
              textColor: Colors.white),
        ),
      ),
    );
  }
}
