import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [Colors.white, Colors.cyan],
            begin: Alignment.centerRight,
            end: new Alignment(-1.0, -1.0)),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Relevart',
                style: TextStyle(
                    fontSize: 64,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'My travel book!',
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () => Navigator.of(context)
                        .pushNamed('/welcome_page/sign_in'),
                    child: Text('Вход'),
                    style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(fontSize: 16))),
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () {},
                    child: Text('Регистрация'),
                    style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(fontSize: 16))),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
