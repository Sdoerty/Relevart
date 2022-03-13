import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModelForm extends ChangeNotifier {
  String travelName = "";
  CollectionReference title_travel =
      FirebaseFirestore.instance.collection('title_travel');
  String _title = "";
// String travelDescription = "";
// DateTime dateTravel = DateTime.now();

/*  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateTravel,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != dateTravel) {
      dateTravel = picked;
      notifyListeners();
    }
  }*/
}

class CreateTravel extends StatelessWidget {
  const CreateTravel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Начать путешествие'),
        backgroundColor: Colors.blueGrey,
      ),
      body: SafeArea(
          child: ChangeNotifierProvider(
        create: (context) => ModelForm(),
        child: TravelForm(),
      )),
    );
  }
}

class TravelForm extends StatelessWidget {
  const TravelForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleTravelFormWidget(),
      ],
    );
  }
}

class TitleTravelFormWidget extends StatefulWidget {
  const TitleTravelFormWidget({Key? key}) : super(key: key);

  @override
  State<TitleTravelFormWidget> createState() => _TitleTravelFormWidgetState();
}

class _TitleTravelFormWidgetState extends State<TitleTravelFormWidget> {
  @override
  Widget build(BuildContext context) {
    final model = context.read<ModelForm>();

    return Padding(
      padding: EdgeInsets.only(left: 15, top: 20, right: 15, bottom: 0),
      child: Column(
        children: [
          TextField(
            onChanged: (String value) {
              model._title = value;
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Название путешествия",
                hintText: 'можно ввести маршрут или город'),
          ),
          ElevatedButton(
              onPressed: () => {
                    model.title_travel.add({'title_travel': model._title}),
                    Navigator.of(context).pop(),
                  },
              child: Text('Добавить'))
        ],
      ),
    );
  }
}
