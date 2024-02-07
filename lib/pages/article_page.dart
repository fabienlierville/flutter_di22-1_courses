import 'dart:io';

import 'package:courses/models/article.dart';
import 'package:courses/pages/article_add_page.dart';
import 'package:courses/repositories/article_repository.dart';
import 'package:flutter/material.dart';
import 'package:courses/models/magasin.dart';

class ArticlePage extends StatefulWidget {
  final Magasin magasin;
  const ArticlePage({super.key, required this.magasin});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  List<Article> articles = [];

  @override
  void initState() {
    recuperer();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.magasin.nom),
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                    return ArticleAddPage(magasin: widget.magasin);
                  })).then((value) {
                    print(value);
                    recuperer();
                  });
                },
                child: new Text('Ajouter')
            )
          ]


      ),
        body: (articles == null || articles?.length ==0)
            ? Text("Aucune données")
            : GridView.builder(
            itemCount: articles.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context,i){
              Article article = articles![i];
              return Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(article.nom),
                      Container(
                        height: MediaQuery.of(context).size.height/6,
                        child: (article.image == null || article.image.length == 0)
                            ? Image.asset("assets/images/no_image.png")
                            : Image.file(File(article.image), fit: BoxFit.contain,),
                      ),

                    Text((article.prix ==null) ? "Aucun prix renseigné" : "Prix: ${article.prix}€"),

                  ],
                ),
              );
            }
        )

    );
  }

  void recuperer() async{
    List<Article> articleList = await ArticleRepository.getAll(widget.magasin);
    setState(() {
      articles = articleList;
    });
  }

}
