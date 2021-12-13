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
                    // ListView позволяет включить скроллинг обектов внутри себя
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 430,
                            child: Center(
                              child: Column(
                                children: [
                                  // Карточка путешествия
                                  GestureDetector(
                                    onTap: () => Navigator.pushNamed(context, '/travel_page'),
                                    child: Container(
                                      margin: const EdgeInsets.all(8.0),
                                      child: Card(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0))),
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
                                            const ListTile(
                                              title: Text(
                                                'Финляндия - Норвегия - Швеция - Эстония',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              subtitle: Text(
                                                  'Путешествие по Скандинавским странам с конца 2019 года до конца зимы 2020 года'),
                                            ),
                                            Container(
                                              child: const Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10)),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceAround,
                                              children: [
                                                Column(
                                                  children: const [
                                                    Text('20.03.2020')
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Row(
                                                      children: const [
                                                        Icon(Icons.thumb_up),
                                                        Text('125')
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Container(
                                              child: const Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),

                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                    /*child: */
                  ),
                  // Незавершенные путешествия
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
                            Text('Незавершенные путешествия',
                                style: TextStyle(fontSize: 18))
                          ],
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                ],
                  ),
                )
              ],
            )));
  }
}
