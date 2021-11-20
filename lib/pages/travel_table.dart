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
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: OutlinedButton.icon(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white, width: 1),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(18),
                  ),
                ),
              ),
              icon: const Icon(
                Icons.assistant_navigation,
                color: Colors.white,
              ),
              label: const Text(
                'Начать путешествие',
                style: TextStyle(color: Colors.white, fontSize: 16),
              )),
          centerTitle: true,
          bottom: const TabBar(
            tabs: <Widget>[
              // Вкладка путешествий в процессе
              Tab(
                icon: Icon(Icons.coffee),
              ),
              // Вкладка завершенных путешествий
              Tab(
                icon: Icon(Icons.call_split),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            // Завершенные путешествия
            SafeArea(
              child: Column(
                children: [
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                              left: 0, top: 25, right: 0, bottom: 0)),
                      Text('Завершенные путешествия',
                          style: TextStyle(fontSize: 18))
                    ],
                  ),
                  Divider(),
                  // Карточка путешествия
                  Container(
                    margin:EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                              child: Image(image: AssetImage('assets/mountain.jpeg'))
                          ),
                          ListTile(
                            title: Text('Финляндия - Норвегия - Швеция - Эстония'),
                            subtitle: Text('Путешествие по Скандинавским странам с конца 2019 года до конца зимы 2020 года'),
                            ),
                          Container(
                            child:
                            Padding(padding: EdgeInsets.only(bottom: 25)),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Незавершенные путешествия
            SafeArea(
              child: Column(
                children: [
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                              left: 0, top: 25, right: 0, bottom: 0)),
                      Text('Незавершенные путешествия',
                          style: TextStyle(fontSize: 18))
                    ],
                  ),
                  Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
