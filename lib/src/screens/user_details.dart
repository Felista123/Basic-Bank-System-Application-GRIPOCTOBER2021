import 'dart:ui';

import 'package:banksystem/model/user.dart';
import 'package:banksystem/sqlite/database.dart';
//import 'package:banksystem/src/screens/home.dart';
import 'package:banksystem/src/screens/transfermoney.dart';
import 'package:flutter/material.dart';

class UserDetailPage extends StatefulWidget {
  final int userAC;
  const UserDetailPage({
    Key? key,
    required this.userAC,
  }) : super(key: key);

  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  late User user;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshUser();
  }

  Future refreshUser() async {
    setState(() => isLoading = true);
    this.user = await BankDatabase.instance.readUser(widget.userAC);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Customer Details',
            style: TextStyle(fontSize: 24),
          ),
          actions: [],
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : userDetails(),
      );
  Widget userDetails() => Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      text: 'Name: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 30),
                      children: [
                        TextSpan(
                          text: user.name,
                          style: TextStyle(color: Colors.black, fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      text: 'Account Number: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 15),
                      children: [
                        TextSpan(
                          text: user.ac.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      text: 'Email: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 15),
                      children: [
                        TextSpan(
                          text: user.email,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      text: 'Current Balance: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 15),
                      children: [
                        TextSpan(
                          text: 'Rs. ' + user.balance.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      text: 'Phone Number: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 15),
                      children: [
                        TextSpan(
                          text: user.number,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(onPrimary: Colors.blue),
                      onPressed: () async {
                        await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              TransferMoneyPage(userAC: user.ac!),
                        ));
                      },
                      child: Text(
                        'Transfer Money',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  /*Widget backbutton() => IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () async {
          if (isLoading) return;

          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Home(),
          ));
        },
      );*/
}
