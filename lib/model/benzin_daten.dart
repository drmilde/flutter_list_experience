class BenzinDaten {
  String Name = "Super";
  double Preis = 1.56;
  String Tankstelle = "Jet, an der Strasse nach Lauterbach";
  double lat = 50.5558;
  double lng = 9.6808;

  BenzinDaten(this.Name, this.Preis, this.Tankstelle, this.lat, this.lng);
}

class BenzinListe {
  late List<BenzinDaten> data;

  BeninzinDaten() {
    data = [];
  }

  void add(BenzinDaten d) {
    data.add(d);
  }
}
