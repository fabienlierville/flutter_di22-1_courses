
import 'package:sqflite/sqflite.dart';

class DatabaseService{
  static Database? _database;

  // Getter qui donne la connexion (et la créé si null)
  static Future<Database> get database async{
    if(_database == null){
      _database = await _opendb();
    }
    return _database!;
  }

  static Future<Database> _opendb() async{
    Database bdd = await openDatabase("./data/database.db", version: 1, onCreate: _onCreate);
    return bdd;
  }

  static Future<void> _onCreate(Database bdd, int version) async{
    await bdd.execute('''
      CREATE TABLE magasin(
        id INTEGER PRIMARY KEY,
        nom VARCHAR(50) NOT NULL
      )
    ''');
  }
}