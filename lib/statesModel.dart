// To parse this JSON data, do
//
//     final states = statesFromJson(jsonString);

import 'dart:convert';

States statesFromJson(String str) => States.fromJson(json.decode(str));

String statesToJson(States data) => json.encode(data.toJson());

class States {
  States({
    this.result,
  });

  List<Result> result;

  factory States.fromJson(Map<String, dynamic> json) => States(
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
    this.countryId,
    this.countryName,
    this.stateCode,
  });

  int id;
  String name;
  int countryId;
  String countryName;
  String stateCode;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        countryId: json["country_id"],
        countryName: json["country_name"],
        stateCode: json["state_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country_id": countryId,
        "country_name": countryName,
        "state_code": stateCode,
      };
}
