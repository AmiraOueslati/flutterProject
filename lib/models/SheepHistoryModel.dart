class SheepHistoryModel {
  String? sId;
  int? sensorId;
  int? iV;
  int? age;
  String? description;
  String? image;
  String? lastUpdated;
  List<Location>? location;
  String? name;

  SheepHistoryModel({
    this.sId,
    this.sensorId,
    this.iV,
    this.age,
    this.description,
    this.image,
    this.lastUpdated,
    this.location,
    this.name,
  });

  SheepHistoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sensorId = json['sensorId'];
    iV = json['__v'];
    age = json['age'];
    description = json['description'];
    image = json['image'];
    lastUpdated = json['lastUpdated'];
    if (json['location'] != null) {
      location = <Location>[];
      json['location'].forEach((v) {
        location!.add(Location.fromJson(v));
      });
    }
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['sensorId'] = sensorId;
    data['__v'] = iV;
    data['age'] = age;
    data['description'] = description;
    data['image'] = image;
    data['lastUpdated'] = lastUpdated;
    if (location != null) {
      data['location'] = location!.map((v) => v.toJson()).toList();
    }
    data['name'] = name;
    return data;
  }

  /// Fonction pour obtenir toutes les latitudes
  List<double> getLatitudes() {
    if (location == null || location!.isEmpty) {
      return [];
    }
    return location!.map((loc) => loc.latitude ?? 0.0).toList();
  }

  /// Fonction pour obtenir toutes les longitudes
  List<double> getLongitudes() {
    if (location == null || location!.isEmpty) {
      return [];
    }
    return location!.map((loc) => loc.longitude ?? 0.0).toList();
  }
}

class Location {
  double? latitude;
  double? longitude;
  String? sId;
  String? timestamp;

  Location({this.latitude, this.longitude, this.sId, this.timestamp});

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    sId = json['_id'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['_id'] = sId;
    data['timestamp'] = timestamp;
    return data;
  }
}
