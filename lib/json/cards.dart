import 'dart:convert';



List<Cards> cardsFromJson(String str) => List<Cards>.from(json.decode(str).map((x) => Cards.fromJson(x)));

String cardsToJson(List<Cards> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cards {
  Cards({this.altDescription, this.urls, this.user,});

  String altDescription;
  Urls urls;
  User user;

  factory Cards.fromJson(Map<String, dynamic> json) => Cards(
    altDescription: json["alt_description"] == null ? null : json["alt_description"],
    urls: Urls.fromJson(json["urls"]),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "alt_description": altDescription == null ? null : altDescription,
    "urls": urls.toJson(),
    "user": user.toJson(),
  };
}

class Urls {
  Urls({this.full, this.regular});

  String full;
  String regular;

  factory Urls.fromJson(Map<String, dynamic> json) => Urls(
    full: json["full"],
    regular: json["regular"],
  );

  Map<String, dynamic> toJson() => {
    "full": full,
    "regular": regular,
  };
}

class User {
  User({this.username});

  String username;

  factory User.fromJson(Map<String, dynamic> json) => User(
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
  };
}




