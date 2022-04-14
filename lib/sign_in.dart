import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:relevart/services/firebase_service.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [Colors.white, Colors.cyan],
              begin: Alignment.centerLeft,
              end: new Alignment(-1.0, -1.0)),
        ),
        child: Center(child: GoogleSignIn()),
      ),
    );
  }
}

class GoogleSignIn extends StatefulWidget {
  const GoogleSignIn({Key? key}) : super(key: key);

  @override
  State<GoogleSignIn> createState() => _GoogleSignInState();
}

class _GoogleSignInState extends State<GoogleSignIn> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? OutlinedButton.icon(
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              FirebaseService service = new FirebaseService();
              try {
                await service.signInWithGoogle();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/bottom_navigation', (route) => false);
              } catch (e) {
                if (e is FirebaseAuthException) {
                  showMessage(e.message!);
                }
              }
              setState(() {
                isLoading = false;
              });
            },
            icon: FaIcon(FontAwesomeIcons.google),
            label: Text("Войти через Google"),
          )
        : CircularProgressIndicator();
  }

  // Сообщение об ошибке входа Google sign in
  void showMessage(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(message),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
