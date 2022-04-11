import 'package:flutter/material.dart';
import 'package:relevart/services/cloud/cloud_travel.dart';

class TravelView extends StatelessWidget {
  final Iterable<CloudTravel> travels;

  const TravelView({Key? key, required this.travels}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(6),
        itemCount: travels.length,
        itemBuilder: (BuildContext context, int index) {
          final travel = travels.elementAt(index);
          return SizedBox(
            height: 450,
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(
                  context, '/bottom_navigation/travel_page', arguments: {
                    'id': travel.travelId
              }),
              child: Container(
                margin: const EdgeInsets.all(6),
                child: Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Stack(
                        children: [
                          const ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                              child: Image(
                                  image: AssetImage('assets/mountain.jpeg'))),
                          Positioned(
                              top: 7,
                              right: 10,
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.share),
                                color: Colors.white,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        title: Text(
                          travel.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          travel.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 17),
                        child: Row(
                          children: [
                            //Text("${travel.dateTravel}")
                            Text(travel.stringFromDate(travel.dateTravel))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
