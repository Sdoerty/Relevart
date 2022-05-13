import 'package:flutter/material.dart';
import 'package:relevart/pages/travel/add_new_travelday.dart';
import 'package:relevart/services/cloud/cloud_travel.dart';
import 'package:relevart/style/create_travel_fields.dart';

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      "создано: ${travelById.stringFromDate(travelById.dateTravel)}",
                      style: TextStyle(fontSize: 16, color: Colors.black54)),
                  Text("всего заметок: ${travelById.travelday.length}")
                ],
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: travelById.travelday.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10),
                          decoration: selfFieldDecoration(),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('${travelById.stringFromDate(travelById.dateTravel)}'),
                                ],
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              TextWrapper(
                                  text: travelById.travelday.elementAt(index)),
                            ],
                          )),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                );
              },
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
          ],
        ),
      ),
    );
  }
}

class TextWrapper extends StatefulWidget {
  const TextWrapper({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  _TextWrapperState createState() => _TextWrapperState();
}

class _TextWrapperState extends State<TextWrapper>
    with TickerProviderStateMixin {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: ConstrainedBox(
              constraints: isExpanded
                  ? const BoxConstraints()
                  : const BoxConstraints(maxHeight: 70),
              child: Text(
                widget.text,
                style: const TextStyle(fontSize: 16),
                softWrap: true,
                overflow: TextOverflow.fade,
              ))),
      isExpanded
          ? TextButton.icon(
              icon: const Icon(Icons.arrow_upward),
              label: const Text('Скрыть'),
              onPressed: () => setState(() => isExpanded = false))
          : TextButton.icon(
              icon: const Icon(Icons.arrow_downward),
              label: const Text('Подробнее'),
              onPressed: () => setState(() => isExpanded = true))
    ]);
  }
}
