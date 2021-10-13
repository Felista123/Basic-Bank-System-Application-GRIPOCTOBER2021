import 'package:banksystem/model/transfer.dart';
import 'package:banksystem/model/user.dart';
//import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BankDatabase {
  static final BankDatabase instance = BankDatabase._init();

  static Database? _database;
  BankDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('Bank.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final acType = 'INTEGER PRIMARY KEY';
    final incType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final stringType = 'TEXT NOT NULL';
    final integerType = 'INTEGER NOT NULL';
    final doubleType = 'DOUBLE NOT NULL';
    await db.execute('''CREATE TABLE $tableUser(
      ${UserFields.ac} $acType,
      ${UserFields.name} $stringType,
      ${UserFields.email} $stringType,
      ${UserFields.balance} $doubleType,
      ${UserFields.number} $stringType
    )''');
    await db.execute('''CREATE TABLE $tableTransfer(
      ${TransferFields.id} $incType,
      ${TransferFields.senderac} $integerType,
      ${TransferFields.sendername} $stringType,
      ${TransferFields.receiverac} $integerType,
      ${TransferFields.recievername} $stringType,
      ${TransferFields.money} $doubleType
    )''');
  }

  Future<User> createUser(User user) async {
    final db = await instance.database;
    /*final json = user.toJson();
    final columns =
        '${UserFields.name}, ${UserFields.email}, ${UserFields.balance}, ${UserFields.number}';
    final values =
        '${json[UserFields.name]}, ${json[UserFields.email]}, ${json[UserFields.balance]}, ${json[UserFields.number]}';
    final ac = await db
        .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');
    */
    final ac = await db.insert(tableUser, user.toJson());
    return user.copy(ac: ac);
  }

  Future<Transfer> createTransfer(Transfer trans) async {
    final db = await instance.database;
    final id = await db.insert(tableTransfer, trans.toJson());
    print('Transfer created!');
    return trans.copy(id: id);
  }

  Future<User> readUser(int ac) async {
    final db = await instance.database;
    final maps = await db.query(
      tableUser,
      columns: UserFields.values,
      where: '${UserFields.ac} = ?',
      whereArgs: [ac],
    );
    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      throw Exception('Accout number $ac not found');
    }
  }

  Future<User> readUserName(String name) async {
    final db = await instance.database;
    final maps = await db.query(
      tableUser,
      columns: UserFields.values,
      where: '${UserFields.name} = ?',
      whereArgs: [name],
    );
    print("Username retrieved!");
    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      throw Exception('Customer name $name not found');
    }
  }

  Future<List<User>> readAllUsers() async {
    /*var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'Bank.db');
    await deleteDatabase(path);*/
    final db = await instance.database;
    final orderBy = '${UserFields.ac}';
    final result = await db.query(tableUser, orderBy: orderBy);
    return result.map((json) => User.fromJson(json)).toList();
  }

  Future<Transfer> readTransfer(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableUser,
      columns: TransferFields.values,
      where: '${TransferFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Transfer.fromJson(maps.first);
    } else {
      throw Exception('ID number $id not found');
    }
  }

  Future<List<Transfer>> readAllTransfers() async {
    final db = await instance.database;
    final orderBy = '${TransferFields.id} DESC';
    final result = await db.query(tableTransfer, orderBy: orderBy);
    return result.map((json) => Transfer.fromJson(json)).toList();
  }

  Future<int> userUpdate(User user) async {
    final db = await instance.database;
    print("User updated!");
    return db.update(
      tableUser,
      user.toJson(),
      where: '${UserFields.ac} = ?',
      whereArgs: [user.ac],
    );
  }

  Future<int> transferUpdate(Transfer trans) async {
    final db = await instance.database;

    return db.update(
      tableTransfer,
      trans.toJson(),
      where: '${TransferFields.id} = ?',
      whereArgs: [trans.id],
    );
  }

  Future<int> userdelete(int ac) async {
    final db = await instance.database;
    return await db.delete(
      tableUser,
      where: '${UserFields.ac} = ?',
      whereArgs: [ac],
    );
  }

  Future<int> transferdelete(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableUser,
      where: '${TransferFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
