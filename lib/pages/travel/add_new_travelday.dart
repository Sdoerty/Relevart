import 'package:flutter/material.dart';

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
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 15, top: 20, right: 15, bottom: 0),
            child: Column(
              children: [
                SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.multiline,
                  minLines: 5,
                  maxLines: 5,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      labelText: "Описание дня",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      hintText: 'опишите всё что происходило в этот день...'),
                ),
                SizedBox(height: 15),
                SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Container(
                              child: Text(
                                "01.01.2000",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey),
                              ),
                            ),
                            Container(
                                child:
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
                                )),
                          ],
                        ),
                        Divider(),
                        Column(
                          children: [
                            Container(
                                margin: EdgeInsets.symmetric(horizontal: 50),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey)
                                ),
                                height: 100,
                                child: Center(child: Text('Нет обложки'))),
                            Container(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
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
                          ],
                        ),
                        Divider(),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)
                            ),
                            height: 100,
                            child: Center(child: Text('отметки на карте'))),
                      ],
                    )),

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
                        onPressed: (){},
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
    );
  }
}
