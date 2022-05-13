import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:relevart/services/cloud/cloud_travel.dart';
import 'package:relevart/services/cloud/firebase_cloud_storage.dart';
import 'package:relevart/style/create_travel_fields.dart';

class ModelAddNewTravelday extends ChangeNotifier{
  final firebaseCloudStorage = FirebaseCloudStorage();
  late String _newDayText;
}

class AddNewTravelday extends StatelessWidget {
  const AddNewTravelday({Key? key, required this.trvlID}) : super(key: key);
  final String trvlID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Text("Новая запись путешествия"),
    ),
    body: ChangeNotifierProvider(
        create: (context) => ModelAddNewTravelday(),
        child: AddNewTraveldayForm(catchTravelId: trvlID))
    );
  }
}


class AddNewTraveldayForm extends StatefulWidget {
  const AddNewTraveldayForm({Key? key, required this.catchTravelId}) : super(key: key);
  final String catchTravelId;

  @override
  State<AddNewTraveldayForm> createState() => _AddNewTraveldayFormState();
}

class _AddNewTraveldayFormState extends State<AddNewTraveldayForm> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(55.741556, 37.620027);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelAddNewTravelday>();
    return SingleChildScrollView(
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
                    onChanged: (String value){
                      model._newDayText = value;
                    },
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
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: selfFieldDecoration(),
                child: Column(
                  children: [
                    Text(
                      "Latitude, Longitude?",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: OutlinedButton.icon(
                        onPressed: () => showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              insetPadding: EdgeInsets.symmetric(horizontal: 16),
                              title: Text('Можно указать метки или нарисовать маршрут'),
                              content: Container(
                                height: 500,
                                width: 500,
                                child: GoogleMap(
                                  onMapCreated: _onMapCreated,
                                  initialCameraPosition: CameraPosition(
                                    target: _center,
                                    zoom: 15.0,
                                  ),
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Принять'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Отмена'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                        style: ElevatedButton.styleFrom(
                          padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        ),
                        icon: Icon(
                          Icons.map,
                          color: Colors.blueGrey,
                        ),
                        label: Text(
                          'Указать метки на карте',
                          style: TextStyle(color: Colors.blueGrey, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
                      onPressed: () async => {
                        await model.firebaseCloudStorage.addNewTravelday(travelId: widget.catchTravelId, textDay: model._newDayText),
                        Navigator.pop(context, true),
                      },
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
