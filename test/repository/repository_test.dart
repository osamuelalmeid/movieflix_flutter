import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movieflix_flutter/repository/model/movie.dart';
import 'package:movieflix_flutter/repository/repository_interface.dart';

class MockRepository extends Mock implements IRepository {}

@GenerateMocks([IRepository])
void main() {
  MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
  });

  test('Should return list movie when call service', () async {
    when(mockRepository.getNowPlayingMovie())
        .thenAnswer((_) => Future.value([buildMovie(), buildMovie(), buildMovie()]));

    var movies = await mockRepository.getNowPlayingMovie();

    expect(movies.length, 3);
  });
}

buildMovie() {
  Movie(
    backdropPath: "/8s4h9friP6Ci3adRGahHARVd76E.jpg",
    id: 379686,
    originalLanguage: "en",
    originalTitle: "Space Jam: A New Legacy",
    overview: "When LeBron and his young son Dom are trapped in a digital space by a rogue A.I., LeBron must get them home safe by leading Bugs, Lola Bunny and the whole gang of notoriously undisciplined Looney Tunes to victory over the A.I.'s digitized champions on the court. It's Tunes versus Goons in the highest-stakes challenge of his life.",
    popularity: 7153.206,
    posterPath: "/5bFK5d3mVTAvBCXi5NPWH0tYjKl.jpg",
    releaseDate: "2021-07-08",
    title: "Space Jam: A New Legacy",
    video: false,
    voteCount: 1230,
    voteAverage: "7.8"
  );
}