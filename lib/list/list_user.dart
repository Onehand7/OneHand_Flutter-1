import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onehand_app/details/details_user.dart';
import 'package:onehand_app/list/users.dart';
import 'package:onehand_app/menu/animation_route.dart';
import 'package:onehand_app/menu/menu_lateral.dart';
import '../constants.dart';
import '../global.dart';

class ListUser extends StatefulWidget {
  @override
  ListUserState createState() => ListUserState();
}

class ListUserState extends State<ListUser> {
  final _refreshKey = GlobalKey<RefreshIndicatorState>();
  final _db = FirebaseFirestore.instance;
  late List<Users> listUser;
  late bool _isSearching;
  final _controller = new TextEditingController();
  //late Users doc;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    listUser = <Users>[];
    _isSearching = false;

    //readData();
  }

  Widget appBarTitle = Text(
    "Search user",
    style: TextStyle(color: Colors.white),
  );
  Icon icon = Icon(
    Icons.search,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
        actions: [
          IconButton(
            icon: icon,
            onPressed: () {
              setState(() {
                if (this.icon.icon == Icons.search) {
                  this.icon = Icon(
                    Icons.close,
                    color: Colors.white,
                  );
                  this.appBarTitle = TextField(
                    controller: _controller,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.white),
                        hintText: "Search...",
                        hintStyle: TextStyle(color: Colors.white)),
                    onChanged: searchOperation,
                  );
                  _handleSearchStart();
                } else {
                  searchOperation(null.toString());
                  _handleSearchEnd();
                }
              });
            },
          ),
        ],
      ),
      drawer: MenuLateral(),
      body: RefreshIndicator(
        key: _refreshKey,
        onRefresh: readData,
        child: UserListView(),
      ),
    );
  }

  Future<void> readData() async {
    StreamBuilder(
        stream: _db.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          return new ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              //Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              return UserListView();
            }).toList(),
          );
        });
/*
     StreamBuilder(
                stream: _db.collection('users').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return Center(child:CircularProgressIndicator());
                  return UserListView(snapshot.data!.docs);
                }
            );

 */
    Stream<QuerySnapshot> qs = _db.collection('users').snapshots();
    qs.listen((QuerySnapshot onData) => {
          listUser.clear(),
          onData.docs
              .map((doc) => {
                    listUser.add(Users(
                      doc['nombre'],
                      doc['apellido'],
                      doc.id,
                      doc['rol'],
                      doc['active'],
                    )),
                  })
              .toList(),
        });
  }

  Container buildItem(Users doc) {
    return Container(
      height: 120.0,
      margin: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 5.0,
      ),
      child: Stack(
        children: [card(doc), thumbnail(doc)],
      ),
    );
  }

  GestureDetector card(Users doc) {
    return GestureDetector(
      onTap: () {
        Global.doc = doc;
        Navigator.push(context, Animation_route(DetailsUser()))
            .whenComplete(() => Navigator.of(context).pop());
      },
      child: Container(
        height: 130.0,
        margin: EdgeInsets.only(left: 40.0),
        decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black38,
                blurRadius: 5.0,
                offset: Offset(0.0, 5.0),
              )
            ]),
        child: Row(
          children: [
            Container(
              width: 250,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 60.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${doc.nombre}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${doc.apellido}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    Text(
                      '${doc.email}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        '${doc.rol}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container thumbnail(Users doc) {
    return Container(
      alignment: FractionalOffset.centerLeft,
      child: Container(
        height: 90.0,
        width: 90.0,
        decoration: BoxDecoration(
            color: Colors.pink,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(50.0),
            image: DecorationImage(
              image: NetworkImage(''),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xffA4A4A4),
                offset: Offset(1.0, 5.0),
                blurRadius: 3.0,
              )
            ]),
      ),
    );
  }

  void searchOperation(String searchText) {
    if (_isSearching) {}
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.icon = Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = Text(
        "Search user",
        style: new TextStyle(color: Colors.white),
      );
      _controller.clear();
      _isSearching = true;
    });
  }
}

class UserListView extends StatelessWidget {
  final Stream<QuerySnapshot> collectionStream =
      FirebaseFirestore.instance.collection('users').snapshots();
  late final Users doc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: collectionStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Global.doc = Users(
                      snapshot.data!.docs[index]['nombre'],
                      snapshot.data!.docs[index]['apellido'],
                      snapshot.data!.docs[index]['email'],
                      snapshot.data!.docs[index]['rol'],
                      snapshot.data!.docs[index]['active']);
                  Navigator.push(context, Animation_route(DetailsUser()))
                      .whenComplete(() => Navigator.of(context).pop());
                },
                child: Container(
                  height: 300.0,
                  margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                  decoration: BoxDecoration(
                    //color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    //color: Colors.red,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 130.0,
                          //color: Colors.green,
                          child: Image(
                            image: NetworkImage(
                                "https://www.urgencias24h.net/wp-content/uploads/2019/12/electricista-urgente-24h-nou-barris-barcelona.jpg"),
                            width: double.infinity,
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Text("(56)"),
                            ]),
                        Container(
                          //color: Colors.yellow,
                          height: 130,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    size: 25,
                                  ),
                                  Text(
                                    '${snapshot.data!.docs[index]['nombre']} ${snapshot.data!.docs[index]['apellido']}',
                                    style: TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.settings_rounded,
                                    size: 25,
                                  ),
                                  Text("Plomero, Filtraciones",
                                      style: TextStyle(fontSize: 18))
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 25,
                                  ),
                                  Text("Psj. Tomas Elgueta, #1448",
                                      style: TextStyle(fontSize: 18))
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.admin_panel_settings,
                                    size: 35.0,
                                    color: colorBlue,
                                  ),
                                  Icon(
                                    Icons.whatshot,
                                    size: 35.0,
                                    color: colorBlue,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}
