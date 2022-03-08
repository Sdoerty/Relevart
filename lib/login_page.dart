import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../auth.dart';

class Login extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  const Login({Key? key, required this.auth, required this.onSignedIn})
      : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

enum FormType { login, register }

class _LoginState extends State<Login> {
  final formKey = new GlobalKey<FormState>();

  late String _email;
  late String _password;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmut() async {
    if (validateAndSave()) {
      await Firebase.initializeApp();
      try {
        if (_formType == FormType.login) {
          await widget.auth.signIn(_email, _password);
        } else {
          await widget.auth.signUp(_email, _password);
        }
        widget.onSignedIn();
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  void moveToRegister() {
    formKey.currentState!.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState!.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(28.0),
            child: Form(
                key: formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: buildSubmitButtons(),
                          ),
                        ],
                      )
                    ])),
          ),
        ));
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        Text(
          "Welcome to Relevart!",
          style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xff1f282d)),
        ),
        Text(
          "Войдите чтобы продолжить",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black.withOpacity(.6),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 45.0)),
        TextFormField(
          decoration: InputDecoration(labelText: 'Email'),
          validator: (value) =>
              value!.isEmpty ? 'Поле Email не может быть пустым' : null,
          onSaved: (value) => _email = value!,
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
          validator: (value) =>
              value!.isEmpty ? 'Поле Password не может быть пустым' : null,
          onSaved: (value) => _password = value!,
        ),
        Padding(padding: EdgeInsets.only(top: 45.0)),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xff3f5561))),
          onPressed: validateAndSubmut,
          child: Text(
            'Войти',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        TextButton(onPressed: moveToRegister, child: Text('Регистрация'))
      ];
    } else {
      return [
        Text(
          "Welcome to Relevart!",
          style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xff1f282d)),
        ),
        Text(
          "Создайте профиль чтобы войти",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black.withOpacity(.6),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 45.0)),
        TextFormField(
          decoration: InputDecoration(labelText: 'Email'),
          validator: (value) =>
              value!.isEmpty ? 'Поле Email не может быть пустым' : null,
          onSaved: (value) => _email = value!,
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
          validator: (value) =>
              value!.isEmpty ? 'Поле Password не может быть пустым' : null,
          onSaved: (value) => _password = value!,
        ),
        Padding(padding: EdgeInsets.only(top: 45.0)),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xff3f5561))),
            onPressed: validateAndSubmut,
            child: Text(
              'Создать профиль',
              style: TextStyle(fontSize: 18.0),
            )),
        TextButton(
            onPressed: (moveToLogin), child: Text('Уже есть аккаунт? Войти'))
      ];
    }
  }
}
