import 'package:flutter/material.dart';
import 'package:relevart/style/create_travel_fields.dart';

class AddNewTravelday extends StatelessWidget {
  const AddNewTravelday({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Text("Новая запись путешествия"),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromRGBO(243, 243, 243, 0.9),
          child: Padding(
            padding: EdgeInsets.only(left: 15, top: 20, right: 15, bottom: 0),
            child: Column(
              children: [
                Container(
                  decoration: selfFieldDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      minLines: 5,
                      maxLines: 5,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          hintText:
                              'опишите всё что происходило в этот день...'),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: selfFieldDecoration(),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "Apr 16, 2022",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey),
                        ),
                      ),
                      SizedBox(height: 10),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.date_range_outlined,
                          color: Colors.blueGrey,
                        ),
                        label: Text(
                          'Выбрать дату событий',
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: selfFieldDecoration(),
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 70),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          height: 100,
                          child: Center(child: Text('Нет обложки'))),
                      SizedBox(height: 10),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.photo_album,
                          color: Colors.blueGrey,
                        ),
                        label: Text(
                          'Добавить фото',
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  height: 250,
                    decoration: selfFieldDecoration(),
                    child: Center(child: Text('отметки на карте'))),
                SizedBox(height: 15),
                Divider(
                  height: 1,
                ),
                SizedBox(height: 15),
                Divider(
                  height: 1,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Добавить запись'),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blueGrey,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            textStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
