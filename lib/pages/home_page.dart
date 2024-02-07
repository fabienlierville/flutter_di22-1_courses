import 'package:courses/models/magasin.dart';
import 'package:courses/repositories/magasin_repository.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Liste des magasins"),),
      body: Center(
        child: FilledButton(
          child: Text("Ajout d'un magasin"),
          onPressed: () async{
            /*
            //Créer objet Magasin
            Magasin magasin = Magasin(nom: "Leclerc");
            print(magasin);
            // Appeler le Create du repository
            magasin =await  MagasinRepository.add(magasin);
            print(magasin);
             */
            /*
            List<Magasin> magasins = await MagasinRepository.getAll();
            print(magasins);
             */
            Magasin? magasin = await MagasinRepository.getByID(2);
            print(magasin);
          },


        ),
      ),
    );
  }
}
