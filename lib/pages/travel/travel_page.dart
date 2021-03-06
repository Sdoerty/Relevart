import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:relevart/pages/travel/add_new_travelday.dart';
import 'package:relevart/services/cloud/cloud_travel.dart';
import 'package:relevart/style/create_travel_fields.dart';

class TravelPageModel extends ChangeNotifier {
  TravelPageModel({Key? key, required this.travelByIdModel}){
    returnDay();
  }
  final CloudTravel travelByIdModel;

  void returnDay() async {
    await travelByIdModel.travelday;
    notifyListeners();
  }
}

class TravelPageView extends StatelessWidget {
  const TravelPageView({Key? key, required this.travelByIdView})
      : super(key: key);
  final CloudTravel travelByIdView;

  @override
  Widget build(BuildContext context) {
    final model = context.read<TravelPageModel>();
    final countModel = context.watch<TravelPageModel>();
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
                    child: Text("${model.travelByIdModel.title}",
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
                    child: Text("${model.travelByIdModel.description}",
                        style: TextStyle(fontSize: 16, color: Colors.black54)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "всего заметок: ${model.travelByIdModel.travelday.length}",
                      style: TextStyle(fontSize: 16, color: Colors.black54)),
                  Text(
                      "${model.travelByIdModel.stringFromDate(model.travelByIdModel.dateTravel)}",
                      style: TextStyle(fontSize: 16, color: Colors.black54)),
                ],
              ),
            ),
            Divider(
              thickness: 1,
            ),
            ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: model.travelByIdModel.travelday.length,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                      '${model.travelByIdModel.stringFromDate(model.travelByIdModel.dateTravel)}'),
                                ],
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              TextWrapper(
                                  text: model.travelByIdModel.travelday.elementAt(index)),
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
                        onPressed: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AddNewTravelday(
                                      trvlID: model.travelByIdModel.travelId,
                                      cloudTravelId: model.travelByIdModel,
                                    ))),
                        child: Text('Добавить запись'),
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            textStyle: TextStyle(fontSize: 16))),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () => showDialog<void>(
                              context: context,
                              barrierDismissible: false,
                              // user must tap button!
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
                            Text(
                              'Завершить путешествие',
                              style: TextStyle(color: Colors.red),
                            ),
                            Text(
                              '(будет нельзя редактировать/добавлять)',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.grey),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            textStyle: TextStyle(fontSize: 16))),
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

// ---------------------------------------------------------------------

class TravelPage extends StatefulWidget {
  TravelPage({Key? key, required this.travelById}) : super(key: key);
  final CloudTravel travelById;

  @override
  State<TravelPage> createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) =>
            TravelPageModel(travelByIdModel: widget.travelById),
        child: TravelPageView(
          travelByIdView: widget.travelById,
        ));
  }
}

// ---------------------------------------------------------------------

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
