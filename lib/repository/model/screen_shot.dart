import 'package:equatable/equatable.dart';

class Screenshot extends Equatable {
  final String aspect;
  final String imagePath;
  final int height;
  final int width;
  final double voteAverage;
  final int voteCount;

  Screenshot(
      {this.aspect,
      this.imagePath,
      this.height,
      this.width,
      this.voteAverage,
      this.voteCount});

  factory Screenshot.fromJson(Map<String, dynamic> json) {
    if (json == null) {
    return Screenshot();
    }

    return Screenshot(
        aspect: json['aspect_ratio'].toString(),
        imagePath: json['file_path'],
        height: json['height'],
        width: json['width'],
        voteAverage: json['vote_average'],
        voteCount: json['vote_count']);
  }

  @override
  List<Object> get props =>
      [aspect, imagePath, height, width, voteAverage, voteCount];
}
