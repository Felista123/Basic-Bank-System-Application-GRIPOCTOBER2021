import 'package:banksystem/model/user.dart';
import 'package:banksystem/sqlite/database.dart';
import 'package:flutter/material.dart';

class AddUserPage extends StatefulWidget {
  final User? user;

  const AddUserPage({
    Key? key,
    this.user,
  }) : super(key: key);

  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  late int ac;
  late String name;
  late String email;
  late double balance;
  late String number;
  @override
  void initState() {
    super.initState();
    ac = widget.user?.ac ?? 0;
    name = widget.user?.name ?? '';
    email = widget.user?.email ?? '';
    balance = widget.user?.balance ?? 0;
    number = widget.user?.number ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildButton()],
        ),
      );
  Widget buildButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
        ),
        onPressed: addUsers,
        child: Text('Save'),
      ),
    );
  }

  void addUsers() async {
    /*ac = widget.user?.ac ?? 1;
    name = widget.user?.name ?? 'Arun';
    email = widget.user?.email ?? 'arun123@gmail.com';
    balance = widget.user?.balance ?? 60000.00;
    number = widget.user?.number ?? '9783456789';
    await addUser();
    ac = widget.user?.ac ?? 2;
    name = widget.user?.name ?? 'George';
    email = widget.user?.email ?? 'george145@gmail.com';
    balance = widget.user?.balance ?? 90000.00;
    number = widget.user?.number ?? '9345623478';
    await addUser();
    ac = widget.user?.ac ?? 3;
    name = widget.user?.name ?? 'Liza';
    email = widget.user?.email ?? 'liza125@gmail.com';
    balance = widget.user?.balance ?? 80000.00;
    number = widget.user?.number ?? '9234156789';
    await addUser();
    ac = widget.user?.ac ?? 4;
    name = widget.user?.name ?? 'Ummu';
    email = widget.user?.email ?? 'ummu124@gmail.com';
    balance = widget.user?.balance ?? 70000.00;
    number = widget.user?.number ?? '9675643215';
    await addUser();
    ac = widget.user?.ac ?? 5;
    name = widget.user?.name ?? 'Jisoo';
    email = widget.user?.email ?? 'jisoo145@gmail.com';
    balance = widget.user?.balance ?? 50000.00;
    number = widget.user?.number ?? '9786534567';
    await addUser();
    ac = widget.user?.ac ?? 6;
    name = widget.user?.name ?? 'Usha';
    email = widget.user?.email ?? 'usha165@gmail.com';
    balance = widget.user?.balance ?? 100000.00;
    number = widget.user?.number ?? '9453423567';
    await addUser();
    ac = widget.user?.ac ?? 7;
    name = widget.user?.name ?? 'Mrinal';
    email = widget.user?.email ?? 'mrinal189@gmail.com';
    balance = widget.user?.balance ?? 130000.00;
    number = widget.user?.number ?? '9789654321';
    await addUser();
    ac = widget.user?.ac ?? 8;
    name = widget.user?.name ?? 'Lidon';
    email = widget.user?.email ?? 'Lidon185@gmail.com';
    balance = widget.user?.balance ?? 140000.00;
    number = widget.user?.number ?? '9472345623';
    await addUser();
    ac = widget.user?.ac ?? 9;
    name = widget.user?.name ?? 'Anand';
    email = widget.user?.email ?? 'anand453@gmail.com';
    balance = widget.user?.balance ?? 190000.00;
    number = widget.user?.number ?? '8998634567';
    await addUser();
    ac = widget.user?.ac ?? 10;
    name = widget.user?.name ?? 'Nina';
    email = widget.user?.email ?? 'nina523@gmail.com';
    balance = widget.user?.balance ?? 160000.00;
    number = widget.user?.number ?? '9456723453';
    await addUser();*/
    Navigator.of(context).pop();
  }

  Future addUser() async {
    final user = User(
      name: name,
      email: email,
      balance: balance,
      number: number,
    );
    await BankDatabase.instance.createUser(user);
  }
}
