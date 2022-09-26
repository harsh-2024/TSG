// To parse this JSON data, do
//
//     final acadamyModel = acadamyModelFromJson(jsonString);

import 'dart:convert';

List<AcadamyModel> acadamyModelFromJson(String str) => List<AcadamyModel>.from(
    json.decode(str).map((x) => AcadamyModel.fromJson(x)));

String acadamyModelToJson(List<AcadamyModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AcadamyModel {
  AcadamyModel({
    this.id,
    this.email,
    this.password,
    this.role,
    this.nameofacademy,
    this.headcoach,
    this.address,
    this.city,
    this.state,
    this.assistantcoach,
    this.nameofassistants,
    this.facilities,
    this.timing,
    this.youtubelink,
    this.tokens,
    this.phonenumber,
  });

  String id;
  String email;
  String password;
  String role;
  String nameofacademy;
  String headcoach;
  String address;
  String city;
  String state;
  String assistantcoach;
  List<String> nameofassistants;
  String facilities;
  String phonenumber;
  String timing;
  List<String> youtubelink;
  List<dynamic> tokens;

  factory AcadamyModel.fromJson(Map<String, dynamic> json) => AcadamyModel(
        id: json["_id"],
        email: json["email"],
        password: json["password"],
        phonenumber: json["phonenumber"],
        role: json["role"],
        nameofacademy: json["nameofacademy"],
        headcoach: json["headcoach"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        assistantcoach: json["assistantcoach"],
        nameofassistants:
            List<String>.from(json["nameofassistants"].map((x) => x)),
        facilities: json["facilities"],
        timing: json["timing"],
        youtubelink: List<String>.from(json["youtubelink"].map((x) => x)),
        tokens: List<dynamic>.from(json["tokens"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "password": password,
        "role": role,
        "nameofacademy": nameofacademy,
        "headcoach": headcoach,
        "address": address,
        "city": city,
        "state": state,
        "phonenumber": phonenumber,
        "assistantcoach": assistantcoach,
        "nameofassistants": List<dynamic>.from(nameofassistants.map((x) => x)),
        "facilities": facilities,
        "timing": timing,
        "youtubelink": List<dynamic>.from(youtubelink.map((x) => x)),
        "tokens": List<dynamic>.from(tokens.map((x) => x)),
      };
}

Country countryFromJson(String str) => Country.fromJson(json.decode(str));

String countryToJson(Country data) => json.encode(data.toJson());

class Country {
  Country({
    this.result,
  });

  List<Result> result;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
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
    this.phoneCode,
    this.capital,
    this.currency,
    this.currencyName,
    this.currencySymbol,
  });

  int id;
  String name;
  int phoneCode;
  String capital;
  String currency;
  String currencyName;
  String currencySymbol;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        phoneCode: json["phone_code"],
        capital: json["capital"],
        currency: json["currency"],
        currencyName: json["currency_name"],
        currencySymbol: json["currency_symbol"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone_code": phoneCode,
        "capital": capital,
        "currency": currency,
        "currency_name": currencyName,
        "currency_symbol": currencySymbol,
      };
}
