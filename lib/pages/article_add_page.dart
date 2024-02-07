import 'dart:io';
import 'dart:math';
import 'package:courses/models/article.dart';
import 'package:courses/models/magasin.dart';
import 'package:courses/repositories/article_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ArticleAddPage extends StatefulWidget {
  Magasin magasin;
  ArticleAddPage({super.key, required this.magasin});

  @override
  State<StatefulWidget> createState() {
    return _ArticleAddPageState();
  }
}

class _ArticleAddPageState extends State<ArticleAddPage> {
  String? image; // sera utilisée plus tard pour utiliser imagepicker
  String? nom;
  String? prix;
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter'),
        actions: [
          TextButton(
              onPressed: () {
                ajouter();
              },
              child: Text(
                'Valider',
              ))
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Article à ajouter',
              textScaler: TextScaler.linear(1.4),
              style: TextStyle(color: Colors.red, fontStyle: FontStyle.italic),
            ),
            Card(
              elevation: 10.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  (image == null)
                      ? Image.asset('assets/images/no_image.png')
                      : Image.file(File(image!)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.camera_enhance), onPressed: (){
                            getImage(ImageSource.camera);
                      }),
                      IconButton(
                          icon: Icon(Icons.photo_library), onPressed: (){
                            getImage(ImageSource.gallery);
                      })
                    ],
                  ),
                  textfield(TypeTextField.nom, "Nom de l'article"),
                  textfield(TypeTextField.prix, "Prix de l'article"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  TextField textfield(TypeTextField type, String label) {
    return TextField(
      decoration: InputDecoration(labelText: label),
      onChanged: (String string) {
        switch (type) {
          case TypeTextField.nom:
            nom = string;
            break;
          case TypeTextField.prix:
            prix = string;
            break;
        }
      },
    );
  }

  void ajouter() async {
    if (nom != null && prix != null) {
      Article article = Article(
          nom: nom!,
          prix: double.tryParse(prix!)!,
          magasin: widget.magasin.id!,
          image: image ?? "");
      await ArticleRepository.upsert(article);
      Navigator.pop(context); //Retour page précédente
    }
  }

  Future<void> getImage(ImageSource source) async {
    final XFile? pickerdFile = await picker.pickImage(source: source);
    setState(() {
      image = pickerdFile?.path;
    });
  }
}

enum TypeTextField { nom, prix }
