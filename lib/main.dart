import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UsersPage(),
    );
  }
}
 
class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}
 
class _UsersPageState extends State<UsersPage> {
  Future<List<User>> readJson() async {
    final String response = await rootBundle.loadString('assets/users.json');
    final data = await json.decode(response);
    return List<User>.from(data["users"].map((x) => User.fromJson(x)));
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WhatsApp'),
        backgroundColor: Color.fromARGB(255, 60, 102, 61),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
            },
          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [];
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(48.0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                    SizedBox(width: 4.0),
                  ],
                ),
                Expanded(
                  child: Text(
                    'CHAT',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Text(
                    'STATUS',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Text(
                    'CALLS',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<User>>(
        future: readJson(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                final user = snapshot.data![index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.imageUrl),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                      children: [
                        Text('${user.firstName} ${user.lastName}'),
                        Text(
                          "22:00", 
                          style: TextStyle(fontSize: 12), 
                        ),
                      ],
                    ),
                    subtitle: Text(user.email),
                  ),
                );
              },
            );
          }
          return CircularProgressIndicator();
        },
      ),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        child: const Icon(Icons.chat),
        backgroundColor: Color.fromARGB(255, 60, 102, 61),
        )
    );
  }
}
 
class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String imageUrl;
 
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.imageUrl,
  });
 
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      imageUrl: json['image'],
    );
  }
}