import 'package:banksystem/model/user.dart';
import 'package:flutter/material.dart';

class UserDetailWidget extends StatelessWidget {
  UserDetailWidget({
    Key? key,
    required this.user,
    required this.index,
  }) : super(key: key);

  final User user;
  final int index;

  @override
  Widget build(BuildContext context) {
    final color = Colors.blue;

    return Card(
        color: color,
        child: Container(
          constraints: BoxConstraints(minHeight: 30),
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Text(
                user.name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Account no:" + user.ac.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Current Balance: Rs." + user.balance.toString(),
                style: TextStyle(color: Colors.white, fontSize: 15),
              )
            ],
          ),
        ));
  }
}
