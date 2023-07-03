import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

//Handles the google authentication of users

class AuthProvider{

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> signInWithGoogle()async{
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken
    );

    return await firebaseAuth.signInWithCredential(credential); //Firebase sign in
  }

  //Sign out from google sign in

  Future<String> signOut()async{
    await firebaseAuth.signOut();
    await GoogleSignIn(scopes: <String>['email']).signOut();
    return 'Sign out success';
  }

}