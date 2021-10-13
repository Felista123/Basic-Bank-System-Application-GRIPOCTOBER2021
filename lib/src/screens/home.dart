import 'package:banksystem/model/user.dart';
import 'package:banksystem/sqlite/database.dart';
//import 'package:banksystem/src/screens/add.dart';
import 'package:banksystem/src/screens/user_details.dart';
import 'package:banksystem/src/widgets/details.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<User> users;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    refreshUsers();
  }

  @override
  void dispose() {
    BankDatabase.instance.close();
    super.dispose();
  }

  Future refreshUsers() async {
    setState(() => isLoading = true);
    this.users = await BankDatabase.instance.readAllUsers();
    setState(() => isLoading = false);
  }

  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Easy Transfer',
            style: TextStyle(fontSize: 24),
          ),
          actions: [],
        ),
        body: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : users.isEmpty
                  ? Text(
                      'No Users',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  : buildList(),
        ),
        /*floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddUserPage()),
            );
            refreshUsers();
          },
        ),*/
      );
  Widget buildList() => ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UserDetailPage(userAC: user.ac!),
              ));
              refreshUsers();
            },
            child: UserDetailWidget(user: user, index: index),
          );
        },
      );
}
