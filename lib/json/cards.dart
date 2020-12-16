import 'dart:convert';

class UnsplashCardsResponse {
  const UnsplashCardsResponse(this.totalCount, this.cards);

  final int totalCount;
  final List<UnsplashCard> cards;
}

List<UnsplashCard> cardsFromJson(String str) =>
    List<UnsplashCard>.from(json.decode(str).map((x) => UnsplashCard.fromJson(x)));

String cardsToJson(List<UnsplashCard> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UnsplashCard {
  UnsplashCard({this.altDescription, this.urls, this.user});

  String altDescription;
  Urls urls;
  User user;

  factory UnsplashCard.fromJson(Map<String, dynamic> json) => UnsplashCard(
        altDescription: json["alt_description"] == null ? null : json["alt_description"],
        urls: Urls.fromJson(json["urls"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "alt_description": altDescription == null ? null : altDescription,
        "urls": urls.toJson(),
        "user": user.toJson(),
      };

  @override
  String toString() {
    return 'Cards{altDescription: $altDescription, urls: $urls, user: $user}';
  }
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

  @override
  String toString() {
    return 'Urls{full: $full, regular: $regular}';
  }
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
