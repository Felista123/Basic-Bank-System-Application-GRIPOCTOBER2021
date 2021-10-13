import 'package:banksystem/model/transfer.dart';
import 'package:banksystem/model/user.dart';
import 'package:banksystem/sqlite/database.dart';
import 'package:banksystem/src/screens/home.dart';
import 'package:flutter/material.dart';

class TransferMoneyPage extends StatefulWidget {
  final int userAC;
  final Transfer? trans;

  const TransferMoneyPage({
    Key? key,
    this.trans,
    required this.userAC,
  }) : super(key: key);
  @override
  _TransferMoneyPageState createState() => _TransferMoneyPageState();
}

class _TransferMoneyPageState extends State<TransferMoneyPage> {
  late User user;
  late User receiver;
  late List<User> users;
  late List<String> listItem = [];
  bool isLoading = false;
  late double transfer;
  late int? senderac;
  late String sendername;
  late int? receiverac;
  late String receivername;
  late double money;
  TextEditingController controller = new TextEditingController();
  var selectItem;
  @override
  void initState() {
    super.initState();
    senderac = widget.trans?.senderac ?? 0;
    sendername = widget.trans?.sendername ?? '';
    receiverac = widget.trans?.receiverac ?? 0;
    receivername = widget.trans?.receivername ?? '';
    money = widget.trans?.money ?? 0;
    refreshUser();
  }

  Future refreshUser() async {
    setState(() => isLoading = true);
    this.user = await BankDatabase.instance.readUser(widget.userAC);
    this.users = await BankDatabase.instance.readAllUsers();
    List.generate(
        users.length,
        (i) => users[i].ac != user.ac
            ? listItem.add(users[i].name)
            : listItem.add(''));
    listItem.remove('');
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Transfer Money',
            style: TextStyle(fontSize: 24),
          ),
          actions: [],
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : transferDetails(),
      );
  Widget transferDetails() => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            DropdownButton<String>(
              dropdownColor: Colors.white,
              hint: Text(
                "Choose the Customer",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              isExpanded: true,
              items: listItem.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(
                    dropDownStringItem,
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
              onChanged: (String? newValueSelected) {
                setState(() {
                  this.selectItem = newValueSelected;
                });
              },
              value: selectItem,
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 30,
              child: Text(
                'Enter the Amount:',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              onSubmitted: (String userInput) {
                transferMoney(double.parse(controller.text));
                debugPrint("Key submitted!");
                setState(() {
                  //
                });
              },
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(onPrimary: Colors.blue),
                  onPressed: () async {
                    await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Home(),
                    ));
                  },
                  child: Text(
                    'Transfer',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  Future transferMoney(double transfer) async {
    print("Trasnfer MOney");
    this.receiver = await BankDatabase.instance.readUserName(this.selectItem);
    senderac = widget.trans?.senderac ?? this.user.ac;
    sendername = widget.trans?.sendername ?? this.user.name;
    receiverac = widget.trans?.receiverac ?? this.receiver.ac;
    receivername = widget.trans?.receivername ?? this.receiver.name;
    money = widget.trans?.money ?? transfer;
    addTransfer();
    user = User(
        balance: user.balance - transfer,
        ac: user.ac,
        name: user.name,
        number: user.number,
        email: user.email);
    await BankDatabase.instance.userUpdate(user);
    receiver = User(
        balance: receiver.balance + transfer,
        ac: receiver.ac,
        name: receiver.name,
        number: receiver.number,
        email: receiver.email);
    await BankDatabase.instance.userUpdate(receiver);
  }

  Future addTransfer() async {
    final trans = Transfer(
      senderac: senderac,
      sendername: sendername,
      receiverac: receiverac,
      receivername: receivername,
      money: money,
    );
    await BankDatabase.instance.createTransfer(trans);
  }
}
