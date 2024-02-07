
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
    Database bdd = await openDatabase("./data/database.db", version: 2, onCreate: _onCreate,onConfigure: _onConfigure,onUpgrade: _onUpgrade);
    return bdd;
  }
  static Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }


  static Future<void> _onCreate(Database bdd, int version) async{
    await bdd.execute('''
      CREATE TABLE magasin(
        id INTEGER PRIMARY KEY,
        nom VARCHAR(50) NOT NULL
      )
    ''');

    await bdd.execute('''
    CREATE TABLE article (
      id INTEGER PRIMARY KEY,
      nom VARCHAR(50) NOT NULL,

      magasin INTEGER,
      prix float,
      image TEXT,
      FOREIGN KEY (magasin) REFERENCES magasin (id) ON DELETE CASCADE
      )
    ''');
  }

  static Future<void> _onUpgrade(Database db, int versionOnPhone, int versionTarget) async{
    if(versionOnPhone == 1 && versionTarget == 2){
      await db.execute('''
      CREATE TABLE article(
        id INTEGER PRIMARY KEY,
        nom VARCHAR(50) NOT NULL,
        magasin INTEGER,
        prix float,
        image TEXT,
        FOREIGN KEY (magasin) REFERENCES magasin (id) ON DELETE CASCADE
      )
    ''');
    }
  }

}