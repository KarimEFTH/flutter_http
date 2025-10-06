import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

// Exemple 1 : Chargement des données via un bouton
// L'utilisateur doit appuyer sur un bouton pour lancer la requête HTTP.

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool loading = false;
  List data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HTTP Api')),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () async {
                loading = true;
                setState(() {});

                var response = await get(
                  Uri.parse("https://jsonplaceholder.typicode.com/posts"),

                  // Les headers précisent l’identité de l’application et le format de réponse attendu,
                  // assurant une bonne communication avec
                  headers: {
                    "User-Agent": "FlutterApp/1.0",
                    "Accept": "application/json",
                  },
                );
                // print(response);
                // print(response.body);
                // print(response.body[0]);

                var responsebody = jsonDecode(response.body);
                // print(responsebody);
                // print(responsebody[0]);
                // print(responsebody[0]['id']);

                data.addAll(responsebody);
                // print(data[0]);
                // setState(() {});

                loading = false;

                setState(() {});
              },
              child: const Text("Http Request"),
            ),
          ),
          if (loading) Center(child: CircularProgressIndicator()),
          ...List.generate(
            data.length,
            (index) => Card(
              child: ListTile(
                title: Text(data[index]['title']),
                subtitle: Text(data[index]['body']),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Exemple 2 : Chargement automatique des données dans initState()

// class Homepage extends StatefulWidget {
//   const Homepage({super.key});

//   @override
//   State<Homepage> createState() => _HomepageState();
// }

// class _HomepageState extends State<Homepage> {
//   bool loading = true;
//   List data = [];

//   void getData() async {
//     var response = await get(
//       Uri.parse("https://jsonplaceholder.typicode.com/posts"),

//       // Les headers précisent l’identité de l’application et le format de réponse attendu,
//       // assurant une bonne communication avec le serveur.
//       headers: {"User-Agent": "FlutterApp/1.0", "Accept": "application/json"},
//     );

//     var responsebody = jsonDecode(response.body);

//     data.addAll(responsebody);

//     loading = false;

//     setState(() {});
//   }

//   @override
//   void initState() {
//     super.initState();

//     getData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: const Text('HTTP Api'),
//       ),
//       body: ListView(
//         children: [
//           if (loading) Center(child: CircularProgressIndicator()),
//           ...List.generate(
//             data.length,
//             (index) => Card(
//               child: ListTile(
//                 title: Text("${data[index]['title']}"),
//                 subtitle: Text("${data[index]['body']}"),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// Exemple 3 : Utilisation de FutureBuilder
// Ici, le chargement et l'affichage des données sont gérés automatiquement
// par le widget FutureBuilder, sans besoin d'appeler setState().

// class Homepage extends StatefulWidget {
//   const Homepage({super.key});

//   @override
//   State<Homepage> createState() => _HomepageState();
// }

// class _HomepageState extends State<Homepage> {
//   // late Future<List> futureData;

//   Future<List> getData() async {
//     var response = await get(
//       Uri.parse("https://jsonplaceholder.typicode.com/posts"),

//       // Les headers précisent l’identité de l’application et le format de réponse attendu,
//       // assurant une bonne communication avec le serveur.
//       headers: {"User-Agent": "FlutterApp/1.0", "Accept": "application/json"},
//     );

//     List responsebody = jsonDecode(response.body);

//     return responsebody;
//   }

//   // @override
//   // void initState() {
//   //   super.initState();

//   //   futureData = getData();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: const Text('FutureBuilder'),
//       ),
//       body: FutureBuilder<List>(
//         // future: futureData,
//         future: getData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasError) {
//               return Center(child: Text("Erreur : ${snapshot.error}"));
//             }

//             if (snapshot.hasData) {
//               return ListView.builder(
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (context, i) {
//                   return ListTile(
//                     title: Text("${snapshot.data![i]['title']}"),
//                     subtitle: Text("${snapshot.data![i]['body']}"),
//                   );
//                 },
//               );
//             }
//           }

//           return Center(child: const Text("Aucune donnée disponible."));
//         },
//       ),
//     );
//   }
// }
