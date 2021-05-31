// To parse this JSON data, do
//
//     final preisliste = preislisteFromJson(jsonString);

import 'dart:convert';

Preisliste preislisteFromJson(String str) =>
    Preisliste.fromJson(json.decode(str));

String preislisteToJson(Preisliste data) => json.encode(data.toJson());

class Preisliste {
  Preisliste({
    this.data = const[],
  });

  List<Datum> data;

  factory Preisliste.fromJson(Map<String, dynamic> json) => Preisliste(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.name = "",
    this.tankstelle = "",
    this.preis = 0.0,
    this.lat = 0.0,
    this.lng = 0.0,
  });

  String name;
  String tankstelle;
  double preis;
  double lat;
  double lng;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["Name"],
        tankstelle: json["Tankstelle"],
        preis: json["Preis"].toDouble(),
        lat: json["Lat"].toDouble(),
        lng: json["Lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Tankstelle": tankstelle,
        "Preis": preis,
        "Lat": lat,
        "Lng": lng,
      };
}
