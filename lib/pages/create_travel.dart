import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:relevart/services/cloud/cloud_travel.dart';
import 'package:relevart/services/cloud/firebase_cloud_storage.dart';

class ModelForm extends ChangeNotifier {
  final _userId = FirebaseAuth.instance.currentUser!.uid;
  final firebaseCloudStorage = FirebaseCloudStorage();
  File? imageFile;
  final cloudTravel = CloudTravel(
      travelId: '',
      ownerUserId: '',
      title: '',
      description: '',
      dateTravel: DateTime.now());

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: await cloudTravel.dateTravel,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != cloudTravel.dateTravel) {
      cloudTravel.dateTravel = picked;
      notifyListeners();
    }
  }

  _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 200,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
    notifyListeners();
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
    final date =
        context.select((ModelForm date) => date.cloudTravel.dateTravel);
    final modelSelectDate = context.read<ModelForm>();
    final image = context.select((ModelForm image) => image.imageFile);
    final modelImage = context.watch<ModelForm>();

    return Padding(
      padding: EdgeInsets.only(left: 15, top: 20, right: 15, bottom: 0),
      child: Column(
        children: [
          SizedBox(
              child: Column(
            children: [
              image != null
                  ? Container(
                      child: Image.file(
                        image,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)
                      ),
                      height: 200,
                      child: Center(child: Text('Нет обложки'))),
              Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    OutlinedButton(
                      onPressed: () {
                        modelImage._getFromGallery();
                      },
                      child: Text("Выбрать обложку из галереи",
                          style: TextStyle(color: Colors.black54)),
                    ),
                  ],
                ),
              ),
            ],
          )),
          SizedBox(height: 30),
          TextField(
            onChanged: (String value) {
              model.cloudTravel.title = value;
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
              model.cloudTravel.description = value;
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
                hintText: 'общее описание, ожидания...'),
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => {
                        model.firebaseCloudStorage.createNewTravel(
                            ownerUserId: model._userId,
                            title: model.cloudTravel.title,
                            description: model.cloudTravel.description,
                            dateTravel: date),
                        Navigator.of(context).pop(),
                      },
                  child: Text('Создать'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blueGrey,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      textStyle: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold))),
            ),
          ),
        ],
      ),
    );
  }
}
