class City extends Comparable<City> {
  int id;
  String name;
  String? state;
  String? country;
  Coordinates coord;

  City(this.id, this.name, this.state, this.country, this.coord);
  City.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        state = json['state'],
        country = json['country'],
        coord = Coordinates.fromJson(json['coord']);

  static List<City> listFromJson(List<dynamic> json) {
    List<City> ret = [];
    for (var d in json) {
      ret.add(City.fromJson(d));
    }
    return ret;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'state': state,
      'country': country,
      'coord': coord.toJson()
    };
  }

  @override
  int compareTo(City other) {
    return id.compareTo(other.id);
  }
}

class Coordinates {
  String lon;
  String lat;

  Coordinates({required this.lat, required this.lon});
  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
        lat: json['lat'].toString(), lon: json['lon'].toString());
  }

  Map<String, dynamic> toJson() {
    return {'lat': lat, 'lon': lon};
  }
}

class CityChron {
  int timeStamp;
  City city;
  DateTime get date {
    return DateTime.fromMicrosecondsSinceEpoch(timeStamp);
  }

  CityChron(this.city, this.timeStamp);
}
