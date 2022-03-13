import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModelForm extends ChangeNotifier {
  CollectionReference travel = FirebaseFirestore.instance.collection('travel');
  String _title = "";
  String _description = "";
  DateTime _dateTravel = DateTime.now();

  Future<void> create_travel() {
    return travel.add({
      'travel_title': _title,
      'travel_description': _description,
      'travel_date': _dateTravel,
    });
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateTravel,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _dateTravel) {
      _dateTravel = picked;
      notifyListeners();
    }
  }
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
      body: SingleChildScrollView(
        child: SafeArea(
            child: ChangeNotifierProvider(
          create: (context) => ModelForm(),
          child: TravelForm(),
        )),
      ),
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
    final date = context.select((ModelForm date) => date._dateTravel);
    final modelSelectDate = context.read<ModelForm>();

    return Padding(
      padding: EdgeInsets.only(left: 15, top: 20, right: 15, bottom: 0),
      child: Column(
        children: [
          SizedBox(height: 10),
          TextField(
            onChanged: (String value) {
              model._title = value;
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                labelText: "Название путешествия",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                floatingLabelAlignment: FloatingLabelAlignment.center,
                hintText: 'напишите маршрут или город'),
          ),
          SizedBox(height: 15),
          TextField(
            onChanged: (String value) {
              model._description = value;
            },
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 5,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                labelText: "Описание путешествия",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                floatingLabelAlignment: FloatingLabelAlignment.center,
                hintText: 'напишите краткое описание маршрута'),
          ),
          SizedBox(height: 15),
          Divider(
            height: 1,
          ),
          SizedBox(height: 15),
          Text(
            "${date.toLocal()}".split(' ')[0],
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey),
          ),
          OutlinedButton(
              onPressed: () => modelSelectDate._selectDate(context),
              child: Text(
                'Выбрать дату путешествия',
                style: TextStyle(color: Colors.black54),
              )),
          SizedBox(height: 15),
          Divider(
            height: 1,
          ),
          SizedBox(height: 50),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () => {
                      model.create_travel(),
                      Navigator.of(context).pop(),
                    },
                child: Text('Создать'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    textStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          )
        ],
      ),
    );
  }
}
