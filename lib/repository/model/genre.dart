class Genre {

  Genre({this.id, this.name});
  
  final int id;
  final String name;

  String error = "";

  factory Genre.fromJson(dynamic json) {
    if (json == null) {
      return Genre();
    }
    return Genre(id: json['id'], name: json['name']);
  }
}