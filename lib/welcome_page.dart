import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Relevart - Travel Book!', style: TextStyle(fontSize: 28, color: Colors.blueGrey, fontWeight: FontWeight.bold),),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                      onPressed: () => Navigator.of(context).pushNamed('/welcome_page/sign_in'),
                      child: Text('Вход')),
                  OutlinedButton(
                      onPressed: () {},
                      child: Text('Регистрация'))
                ],
              )
            ],
          ),
        ));
  }
}
