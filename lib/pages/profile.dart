import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: 500,
            height: 150,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 44,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/mountain.jpeg'),
                    radius: 40,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Роман Смирнов',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        IconButton(
                            onPressed: () => Navigator.of(context).pushNamed('/profile/settings'),
                            icon: Icon(Icons.edit, color: Colors.white,)),
                      ],
                    ),
                    Text(
                      'Подписки: 3',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Text(
                      'Подписчики: 10',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Статистика:',
                        style: TextStyle(
                            fontSize: 18),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.supervised_user_circle),
                        label: Text('Подписаться'),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.teal,
                            radius: 25,
                            child: Icon(Icons.coffee, color: Colors.white,),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Мои путешествия',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '5 завершено',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.orange,
                            radius: 25,
                            child: Icon(Icons.merge_type, color: Colors.white,),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'В процессе',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '1 ожидают завершения',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
