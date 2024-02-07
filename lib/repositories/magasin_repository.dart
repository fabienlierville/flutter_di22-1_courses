
import 'package:courses/models/magasin.dart';
import 'package:courses/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

class MagasinRepository{

  //Create
  static Future<Magasin> add(Magasin magasin) async{
    //Récupérer connexion BDD
    Database bdd = await DatabaseService.database;
    //Requete
    magasin.id = await bdd.insert("magasin", magasin.toMap());
    return magasin;
  }

  //GetAll
  static Future<List<Magasin>> getAll() async{
    //Récupérer connexion BDD
    Database bdd = await DatabaseService.database;
    List<Map<String,dynamic>> result = await bdd.query("magasin");
    List<Magasin> l =[];
    result.forEach((map) {
      l.add(Magasin.fromMap(map));
    });
    return l;
  }

  //GetByID
  static Future<Magasin?> getByID(int id) async{
    //Récupérer connexion BDD
    Database bdd = await DatabaseService.database;
    List<Map<String,dynamic>> result = await bdd.rawQuery("SELECT id,nom FROM magasin WHERE id=?",[id]);
    if(result.length > 0){
      return Magasin.fromMap(result[0]);
    }
    return null;

  }
  //Update
  static Future<int> update(Magasin magasin) async{
    //Récupérer connexion BDD
    Database bdd = await DatabaseService.database;
    return await bdd.update("magasin", magasin.toMap(),where: "id=?",whereArgs: [magasin.id]);
  }

  //Delete

}