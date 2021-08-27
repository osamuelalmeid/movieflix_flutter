import 'package:equatable/equatable.dart';
import 'package:movieflix_flutter/repository/model/screen_shot.dart';

class MovieImage extends Equatable {
  final List<Screenshot> backdrops;
  final List<Screenshot> posters;

  const MovieImage({this.backdrops, this.posters});

  factory MovieImage.fromJson(Map<String, dynamic> result) {
    if (result == null) {
      return MovieImage();
    }

    return MovieImage(
      backdrops: (result['backdrops'] as List)
              .map((b) => Screenshot.fromJson(b))
              .toList(),
      posters: (result['posters'] as List)
              .map((b) => Screenshot.fromJson(b))
              .toList(),
    );
  }

  @override
  List<Object> get props => [backdrops, posters];
}