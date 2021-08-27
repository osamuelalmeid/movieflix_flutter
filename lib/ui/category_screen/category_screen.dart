import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieflix_flutter/bloc/genre_bloc/genre_bloc.dart';
import 'package:movieflix_flutter/bloc/genre_bloc/genre_event.dart';
import 'package:movieflix_flutter/bloc/genre_bloc/genre_state.dart';
import 'package:movieflix_flutter/bloc/movie_bloc/movie_bloc.dart';
import 'package:movieflix_flutter/bloc/movie_bloc/movie_event.dart';
import 'package:movieflix_flutter/bloc/movie_bloc/movie_state.dart';
import 'package:movieflix_flutter/repository/model/genre.dart';
import 'package:movieflix_flutter/repository/model/movie.dart';
import 'package:movieflix_flutter/ui/detail_movie_screen/detail_movie_screen.dart';

class BuildWidgetCategory extends StatefulWidget {
  const BuildWidgetCategory({Key key, this.selectedGenre = 28})
      : super(key: key);

  final int selectedGenre;

  static String routeName = "/category";

  @override
  _BuildWidgetCategoryState createState() => _BuildWidgetCategoryState();
}

class _BuildWidgetCategoryState extends State<BuildWidgetCategory> {
  int selectedGenre = 0;

  @override
  void initState() {
    super.initState();
    selectedGenre = widget.selectedGenre;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<GenreBloc>(
          create: (_) => GenreBloc()..add(GenreEventStarted())),
      BlocProvider<MovieBloc>(
        create: (_) => MovieBloc()..add(MovieEventStarted(selectedGenre, '')),
      )
    ], child: _buildGenre(context));
  }

  Widget _buildGenre(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<GenreBloc, GenreState>(builder: (context, state) {
          if (state is GenreLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          } else if (state is GenreLoaded) {
            List<Genre> genres = state.genreList;
            return Container(
              height: 45,
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    VerticalDivider(
                  color: Colors.transparent,
                  width: 5,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: genres.length,
                itemBuilder: (context, index) {
                  Genre genre = genres[index];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedGenre = genres[index].id;
                            context
                                .read<MovieBloc>()
                                .add(MovieEventStarted(selectedGenre, ""));
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black45),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              color: (genre.id == selectedGenre)
                                  ? Colors.black45
                                  : Colors.white),
                          child: Text(
                            genre.name.toUpperCase(),
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: (genre.id == selectedGenre)
                                    ? Colors.white
                                    : Colors.black45,
                                fontFamily: 'muli'),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            );
          } else {
            return Center(
              child: Text(
                "Ops! Algo deu errado.",
                style: TextStyle(color: Colors.black),
              ),
            );
          }
        }),
        SizedBox(
          height: 10,
        ),
        Container(
          child: Text(
            "New playing".toUpperCase(),
            style: TextStyle(
                                  color: Colors.black45,
                                  fontFamily: 'muli',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)
          ),
        ),
        SizedBox(
          height: 10,
        ),
        BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state is MovieLoading) {
              return Container(
                height: 280,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                ),
              );
            } else if (state is MovieLoaded) {
              List<Movie> movieList = state.movieList;
              return Container(
                height: 300,
                child: ListView.separated(
                    separatorBuilder: (context, index) => VerticalDivider(
                          color: Colors.transparent,
                          width: 15,
                        ),
                    scrollDirection: Axis.horizontal,
                    itemCount: movieList.length,
                    itemBuilder: (context, index) {
                      Movie movie = movieList[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context, MaterialPageRoute(
                                  builder: (context) => DetailMovieScreen(movie: movie)
                                )
                              );
                            },
                            child: ClipRRect(
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://image.tmdb.org/t/p/original/${movie.backdropPath}",
                                imageBuilder: (context, imageProvider) {
                                  return Container(
                                    width: 180,
                                    height: 250,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover)),
                                  );
                                },
                                placeholder: (context, url) => Container(
                                  width: 180,
                                  height: 250,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                    width: 190,
                                    height: 250,
                                    child: Center(
                                      child: Icon(Icons.error),
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 180,
                            child: Text(movie.title.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'muli'),
                                overflow: TextOverflow.ellipsis),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 14,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 14,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 14,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 14,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 14,
                                ),
                                Text(
                                  movie.voteAverage,
                                  style: TextStyle(color: Colors.black45),
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    }),
              );
            } else {
              return Center(
                child: Text(
                  "Ops! Algo deu errado.",
                  style: TextStyle(color: Colors.black),
                ),
              );
            }
          },
        )
      ],
    );
  }
}
