
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

}