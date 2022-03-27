import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:relevart/pages/travel_view.dart';
import 'package:relevart/services/cloud/cloud_travel.dart';
import 'package:relevart/services/cloud/firebase_cloud_storage.dart';

class TravelTable extends StatefulWidget {
  const TravelTable({Key? key}) : super(key: key);

  @override
  _TravelTableState createState() => _TravelTableState();
}

class _TravelTableState extends State<TravelTable>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late final FirebaseCloudStorage _travelService;
  final _userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    _travelService = FirebaseCloudStorage();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                const TabBar(
                  indicatorWeight: 5,
                  indicatorColor: Colors.blueGrey,
                  labelColor: Color(0xff3f5561),
                  unselectedLabelColor: Colors.grey,
                  tabs: <Widget>[
                    Tab(
                      icon: Icon(Icons.coffee),
                      text: 'Мои путешествия',
                    ),
                    Tab(
                      icon: Icon(Icons.merge_type),
                      text: 'В процессе',
                    ),
                  ],
                ),
                Flexible(
                  child: TabBarView(
                    children: <Widget>[
                      // Мои путешествия
                      SafeArea(
                        child: Column(
                          children: [
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 0, top: 25, right: 0, bottom: 0)),
                                Text('Нет данных',
                                    style: TextStyle(fontSize: 18))
                              ],
                            ),
                            const Divider(),
                          ],
                        ),
                      ),
                      // Незавершенные путешествия
                      StreamBuilder(
                        stream: _travelService.allTravels(ownerUserId: _userId),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                            case ConnectionState.active:
                              if (snapshot.hasData) {
                                final allTravels = snapshot.data as Iterable<CloudTravel>;
                                return TravelView(
                                  travels: allTravels,
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            default:
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            )));
  }
}
