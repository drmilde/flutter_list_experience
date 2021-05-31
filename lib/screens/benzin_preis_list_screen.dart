import 'package:flutter/material.dart';
import 'package:flutter_list_experience/model/benzin_daten.dart';
import 'package:flutter_list_experience/model/preisliste.dart';
import 'package:http/http.dart' as http;

class BenzinPreisListScreen extends StatefulWidget {
  @override
  _BenzinPreisListScreenState createState() => _BenzinPreisListScreenState();
}

class _BenzinPreisListScreenState extends State<BenzinPreisListScreen> {
  late List<BenzinDaten> bl;
  late Preisliste pl;

  Future<Preisliste> _loadDataFromServer() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:3000/data/preisliste.json'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      String inhalt = response.body;
      print(inhalt);
      return preislisteFromJson(inhalt);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<Preisliste> _loadJsonFile() async {
    String inhalt = await DefaultAssetBundle.of(context)
        .loadString("assets/preisliste.json");
    //print(inhalt);
    return preislisteFromJson(inhalt);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    bl = List.generate(
        100,
        (index) => new BenzinDaten(
              "Super",
              1.58,
              "Jet, Leipziger Strasse",
              50.5558,
              9.3214,
            ));

    pl = new Preisliste();
    _loadDataFromServer();
    /*
    _loadJsonFile().then((value) {
      pl = value;
    });

     */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _loadDataFromServer(),
        builder: (context, snapshot) {
          // 1. Fall: konnte noch nicht verbinden und hat noch keine Daten
          if (snapshot.connectionState == ConnectionState.none &&
              snapshot.hasData == null) {
            return Container(
                child: Text("Noch keine aktuellen Preise geladen"));
          }
          // Fall 2: Daten werden noch geladen
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            // Fall 3. Daten wurden vollständig geladen
            pl = snapshot.data as Preisliste;
            return _buildScrollView();
          }
        },
      ),
    );
  }

  Widget _buildScrollView() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          actions: [
            IconButton(
              onPressed: () {
                setState(() {

                });
              },
              icon: Icon(Icons.add),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.remove_circle_outline),
            )
          ],
          pinned: true,
          centerTitle: true,
          backgroundColor: Colors.teal[800],
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            title: Text("Was kostet der Stoff"),
            background: Image.network(
                "https://static.wikia.nocookie.net/bigbangtheory/images/5/57/Amys7.jpg/revision/latest?cb=20140530133904&path-prefix=de",
            fit: BoxFit.cover,
            ),

            centerTitle: true,
          ),
          //title: Text("Was kostet der Stoff?"),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ListTile(
                leading: Icon(Icons.money),
                title: Text("${pl.data[index].name}"),
                subtitle: Text("${pl.data[index].tankstelle}"),
                trailing: Icon(Icons.add),
              );
            },
            childCount: pl.data.length,
          ),
        ),
      ],
    );
  }
}
