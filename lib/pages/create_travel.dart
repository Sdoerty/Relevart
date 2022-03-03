import 'package:flutter/material.dart';

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
        child: TravelForm(),
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
        DescriptionTravelFormWidget(),
        DateTravelFormWidget(),
      ],
    );
  }
}

class TitleTravelFormWidget extends StatelessWidget {
  const TitleTravelFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, top: 20, right: 15, bottom: 0),
      child: TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Название путешествия",
            hintText: 'можно ввести маршрут или город'),
      ),
    );
  }
}

class DescriptionTravelFormWidget extends StatelessWidget {
  const DescriptionTravelFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
      child: TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Описание",
            hintText: 'опишите процесс путешествия'),
      ),
    );
  }
}

class DateTravelFormWidget extends StatefulWidget {
  const DateTravelFormWidget({Key? key}) : super(key: key);

  @override
  State<DateTravelFormWidget> createState() => _DateTravelFormWidgetState();
}

DateTime selectedDate = DateTime.now();

_selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(2000),
    lastDate: DateTime(2025),
  );
  if (picked != null && picked != selectedDate) {
    selectedDate = picked;
  }
}

class _DateTravelFormWidgetState extends State<DateTravelFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 15),
        child: Column(
          children: [
            Text(
              "${selectedDate.toLocal()}".split(' ')[0],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            OutlinedButton(
                onPressed: () => _selectDate(context),
                child: Text('Выбрать дату', style: TextStyle(color: Colors.black54),)),
          ],
        ));
  }
}
