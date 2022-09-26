// To parse this JSON data, do
//
//     final cities = citiesFromJson(jsonString);

import 'dart:convert';

Cities citiesFromJson(String str) => Cities.fromJson(json.decode(str));

String citiesToJson(Cities data) => json.encode(data.toJson());

class Cities {
  Cities({
    this.result,
  });

  List<Result> result;

  factory Cities.fromJson(Map<String, dynamic> json) => Cities(
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.id,
    this.name,
    this.stateId,
    this.stateCode,
    this.stateName,
    this.countryId,
    this.countryCode,
    this.countryName,
    this.latitude,
    this.longitude,
    this.wikiDataId,
  });

  int id;
  String name;
  int stateId;
  String stateCode;
  String stateName;
  int countryId;
  String countryCode;
  String countryName;
  String latitude;
  String longitude;
  String wikiDataId;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        stateId: json["state_id"],
        stateCode: json["state_code"],
        stateName: json["state_name"],
        countryId: json["country_id"],
        countryCode: json["country_code"],
        countryName: json["country_name"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        wikiDataId: json["wikiDataId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "state_id": stateId,
        "state_code": stateCode,
        "state_name": stateName,
        "country_id": countryId,
        "country_code": countryCode,
        "country_name": countryName,
        "latitude": latitude,
        "longitude": longitude,
        "wikiDataId": wikiDataId,
      };
}
