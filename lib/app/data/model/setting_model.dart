import 'dart:convert';

class Settings {
  String logoImage;
  String logoPosition;

  Settings({required this.logoImage, required this.logoPosition});

  Map<String, dynamic> toMap() {
    return {
      'logoImage': logoImage,
      'logoPosition': logoPosition,
    };
  }

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      logoImage: map['logoImage'],
      logoPosition: map['logoPosition'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Settings.fromJson(String source) =>
      Settings.fromMap(json.decode(source));
}
