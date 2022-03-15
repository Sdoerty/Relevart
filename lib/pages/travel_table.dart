import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class TravelTable extends StatefulWidget {
  const TravelTable({Key? key}) : super(key: key);

  @override
  _TravelTableState createState() => _TravelTableState();
}

class _TravelTableState extends State<TravelTable>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
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
                                Text('Завершенные путешествия',
                                    style: TextStyle(fontSize: 18))
                              ],
                            ),
                            const Divider(),
                          ],
                        ),
                      ),
                      // Незавершенные путешествия
                      SafeArea(
                        // ListView позволяет включить скроллинг обектов внутри себя
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('travel')
                              .snapshots(includeMetadataChanges: true),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: Text('Нет записей'));
                            }if(snapshot.connectionState == ConnectionState.waiting){
                              return Center(child: Text("Загрузка..."));
                            } else {
                              return ListView.builder(
                                  padding: const EdgeInsets.all(8),
                                  itemCount: snapshot.data?.docs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      height: 430,
                                      child: Dismissible(
                                        key: Key(snapshot.data!.docs[index].id),
                                        child: GestureDetector(
                                          onTap: () => Navigator.pushNamed(
                                              context,
                                              '/bottom_navigation/travel_page'),
                                          child: Container(
                                            margin: const EdgeInsets.all(8.0),
                                            child: Card(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.0))),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Stack(
                                                    children: [
                                                      const ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    10.0),
                                                          ),
                                                          child: Image(
                                                              image: AssetImage(
                                                                  'assets/mountain.jpeg'))),
                                                      Positioned(
                                                          top: 7,
                                                          right: 10,
                                                          child: IconButton(
                                                            onPressed: () {},
                                                            icon: const Icon(
                                                                Icons.share),
                                                            color: Colors.white,
                                                          ))
                                                    ],
                                                  ),
                                                  ListTile(
                                                    title: Text(
                                                      snapshot.data!.docs[index]
                                                          .get('travel_title'),
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    subtitle: Text(snapshot
                                                        .data!.docs[index]
                                                        .get(
                                                            'travel_description')),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Text(
                                                              '${snapshot.data!.docs[index].get('travel_date').toDate()}')
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Row(
                                                            children: const [
                                                              Icon(Icons
                                                                  .thumb_up),
                                                              Text('125')
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            }
                          },
                        ),
                        /*child: */
                      ),
                    ],
                  ),
                )
              ],
            )));
  }
}
