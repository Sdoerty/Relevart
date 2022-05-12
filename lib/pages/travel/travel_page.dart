import 'package:flutter/material.dart';
import 'package:relevart/pages/travel/add_new_travelday.dart';
import 'package:relevart/services/cloud/cloud_travel.dart';

class TravelPage extends StatelessWidget {
  TravelPage({Key? key, required this.travelById}) : super(key: key);
  final CloudTravel travelById;
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.share),
          color: Colors.white,
        )
      ], backgroundColor: Colors.transparent, elevation: 0.0),
      // впиливает body под низ appBar-a:
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/mountain.jpeg'),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text("${travelById.title}",
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text("${travelById.description}",
                        style: TextStyle(fontSize: 16, color: Colors.black54)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("создано: ${travelById.stringFromDate(travelById.dateTravel)}",
                      style: TextStyle(fontSize: 16, color: Colors.black54)),
                ],
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Text('нет записей'),
            Text('${travelById.travelday}'),
            Divider(
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                       // onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddNewTravelday())),
                        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddNewTravelday(trvlID: travelById.travelId))),
                        child: Text('Добавить запись'),
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            textStyle:
                            TextStyle(fontSize: 16))),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () => showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Завершить путешествие?'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Завершить'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text('Отмена'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                        child: Column(
                          children: [
                            Text('Завершить путешествие', style: TextStyle(color: Colors.red),),
                            Text('(будет нельзя редактировать/добавлять)', style: TextStyle(fontSize: 13, color: Colors.grey),),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            textStyle:
                            TextStyle(fontSize: 16))),
                  ),
                ],
              ),
            )

















            /*Stepper(
              physics: NeverScrollableScrollPhysics(),
              steps: getSteps(),
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    OutlinedButton(
                      onPressed: details.onStepContinue,
                      child: const Text('СЛЕДУЮЩИЙ ДЕНЬ'),
                    ),
                    OutlinedButton(
                      onPressed: details.onStepCancel,
                      child: const Text('НАЗАД'),
                    ),
                  ],
                );
              },
              currentStep: currentStep,
              onStepTapped: (int step) {
                setState(() {
                  currentStep = step;
                });
              },
              onStepCancel: () {
                currentStep > 0 ? setState(() => currentStep -= 1) : null;
              },
              onStepContinue: () {
                currentStep < 2 ? setState(() => currentStep += 1) : null;
              },
            ),*/
          ],
        ),
      ),
    );
  }

/*List<Step> getSteps() {
    return [
      Step(
        title: Text('ДЕНЬ 1'),
        subtitle: Text('11.01.2021'),
        content: Column(
          children: [
            SizedBox(
              width: 400,
              child:
                Text(
                  'Переезд через перевал',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                )
              ,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Divider(height: 1,),
            ),
            SizedBox(
              width: 400,
              child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur."),
            ),
            SizedBox(
              width: 500,
              height: 200,
              child: GridView.count(
                scrollDirection: Axis.horizontal,
                primary: false,
                padding: const EdgeInsets.all(20),
                mainAxisSpacing: 5,
                crossAxisCount: 1,
                children: <Widget>[
                  Container(
                    child: Image(
                      image: AssetImage('assets/mountain.jpeg'),
                    ),
                  ),
                  Container(
                    child: Image(
                      image: AssetImage('assets/mountain.jpeg'),
                    ),
                  ),
                  Container(
                    child: Image(
                      image: AssetImage('assets/mountain.jpeg'),
                    ),
                  ),
                  Container(
                    child: Image(
                      image: AssetImage('assets/mountain.jpeg'),
                    ),
                  ),
                  Container(
                    child: Image(
                      image: AssetImage('assets/mountain.jpeg'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      Step(
        title: Text('ДЕНЬ 2'),
        subtitle: Text('12.01.2021'),
        content: Column(
          children: [
            SizedBox(
              width: 400,
              child:
              Text(
                'Переезд через перевал',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )
              ,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Divider(height: 1,),
            ),
            SizedBox(
              width: 400,
              child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur."),
            ),
            SizedBox(
              width: 500,
              height: 200,
              child: GridView.count(
                scrollDirection: Axis.horizontal,
                primary: false,
                padding: const EdgeInsets.all(20),
                mainAxisSpacing: 5,
                crossAxisCount: 1,
                children: <Widget>[
                  Container(
                    child: Image(
                      image: AssetImage('assets/mountain.jpeg'),
                    ),
                  ),
                  Container(
                    child: Image(
                      image: AssetImage('assets/mountain.jpeg'),
                    ),
                  ),
                  Container(
                    child: Image(
                      image: AssetImage('assets/mountain.jpeg'),
                    ),
                  ),
                  Container(
                    child: Image(
                      image: AssetImage('assets/mountain.jpeg'),
                    ),
                  ),
                  Container(
                    child: Image(
                      image: AssetImage('assets/mountain.jpeg'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      Step(
        title: Text('ДЕНЬ 2'),
        subtitle: Text('12.01.2021'),
        content: Column(
          children: [
            SizedBox(
              width: 400,
              child:
              Text(
                'Переезд через перевал',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )
              ,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Divider(height: 1,),
            ),
            SizedBox(
              width: 400,
              child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur."),
            ),
            SizedBox(
              width: 500,
              height: 200,
              child: GridView.count(
                scrollDirection: Axis.horizontal,
                primary: false,
                padding: const EdgeInsets.all(20),
                mainAxisSpacing: 5,
                crossAxisCount: 1,
                children: <Widget>[
                  Container(
                    child: Image(
                      image: AssetImage('assets/mountain.jpeg'),
                    ),
                  ),
                  Container(
                    child: Image(
                      image: AssetImage('assets/mountain.jpeg'),
                    ),
                  ),
                  Container(
                    child: Image(
                      image: AssetImage('assets/mountain.jpeg'),
                    ),
                  ),
                  Container(
                    child: Image(
                      image: AssetImage('assets/mountain.jpeg'),
                    ),
                  ),
                  Container(
                    child: Image(
                      image: AssetImage('assets/mountain.jpeg'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ];
  }*/
}

class TravelPageView extends StatelessWidget {
  const TravelPageView({Key? key, required this.travels}) : super(key: key);
  final Iterable<CloudTravel> travels;


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}



