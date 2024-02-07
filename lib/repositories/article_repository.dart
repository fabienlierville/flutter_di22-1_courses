
import 'package:courses/models/article.dart';
import 'package:courses/models/magasin.dart';
import 'package:courses/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

class ArticleRepository{
  static Future<List<Article>> getAll(Magasin magasin) async {
    Database bdd = await DatabaseService.database;

    List<Map<String, dynamic>> resultat = await bdd.query(
        'article', where: 'magasin = ?', whereArgs: [magasin.id]);

    List<Article> articles = [];
    resultat.forEach((map) {
      articles.add(Article.fromMap(map));
    });

    return articles;
  }

  static Future<Article> upsert(Article article) async{
    Database myDb = await  DatabaseService.database;
    if (article.id == null) {
      article.id = await myDb.insert('article', article.toMap());
    }else{
      await myDb.update('article', article.toMap(), where: 'id = ?', whereArgs: [article.id]);
    }
    return article;
  }


}
