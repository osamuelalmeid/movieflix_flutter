class Person {
  Person(
      {this.id,
      this.gender,
      this.name,
      this.profilePath,
      this.knowForDepartment,
      this.popularity});

  final String? id;
  final String? gender;
  final String? name;
  final String? profilePath;
  final String? knowForDepartment;
  final String? popularity;

  factory Person.fromJson(dynamic json) {
    if (json == null) {

    }

    return Person(
      id: json['id'].toString(),
        gender: json['gender'].toString(),
        name: json['name'],
        profilePath: json['profile_path'],
        knowForDepartment: json['known_for_department'],
        popularity: json['popularity'].toString());
  }
}
