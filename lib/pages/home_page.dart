import 'package:courses/models/magasin.dart';
import 'package:courses/pages/article_page.dart';
import 'package:courses/repositories/magasin_repository.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Magasin?
      magasinActuel; //Stockera la saisir utilisateur ou le clic de modification
  List<Magasin>? magasins;

  @override
  void initState() {
    recuperer();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des magasins"),
        actions: [TextButton(onPressed: ajoutDialog, child: Text("Ajouter"))],
      ),
      body: (magasins == null || magasins?.length == 0)
          ? Text("Aucun magasin dans la liste")
          : ListView.builder(
          itemCount: magasins?.length,
          itemBuilder: (BuildContext context, int index) {
            Magasin magasin = magasins![index];
            return ListTile(
              title: Text(magasin.nom),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext buildContext){
                    return ArticlePage(magasin: magasin);
                  }));
                },
                leading: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  magasinActuel = magasin;
                  ajoutDialog();
                },
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async{
                  await MagasinRepository.delete(magasin);
                  recuperer();
                },
              ),

            );

          }
      ),

    );
  }

  Future<void> recuperer() async {
    List<Magasin> magasinList = await MagasinRepository.getAll();
    setState(() {
      magasins = magasinList;
    });
  }


  Future<void> ajoutDialog() async {
    String? saisie;

    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title:(magasinActuel?.nom == null) ? Text('Ajouter un magasin') : Text('Modifier ${magasinActuel?.nom}'),
            content: TextField(
              controller: TextEditingController()..text = magasinActuel?.nom ?? "",
              autofocus: true,
              decoration: InputDecoration(
                  labelText: 'Magasin:',
                  hintText: 'ex: Leclerc'
              ),
              onChanged: (String str) {
                //Pas de SetState car c'est une string qui ne sera pas changé ailleurs
                saisie= str;
              },
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    magasinActuel = null; //Quoiqu’il arrive avant de fermer on raz
                    Navigator.pop(buildContext);
                  }
                  , child: Text('Annuler')
              ),
              TextButton(
                  onPressed: () async {
                    if (saisie != null && saisie!.length > 0) {

                      if(magasinActuel == null){
                        magasinActuel = Magasin(nom: saisie!);
                      }else{
                        magasinActuel?.nom = saisie!;
                      }

                      if(magasinActuel!.id != null) {
                        await MagasinRepository.update(magasinActuel!);
                      }else{
                        await MagasinRepository.add(magasinActuel!);
                      }
                      recuperer();
                    }
                    magasinActuel = null; //Quoiqu’il arrive avant de fermer on raz
                    Navigator.pop(buildContext);
                  },
                  child: new Text(
                    'Valider', style: TextStyle(color: Colors.blue),)
              )
            ],
          );
        }
    );
  }

}
