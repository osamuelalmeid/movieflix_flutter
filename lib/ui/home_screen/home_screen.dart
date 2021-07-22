import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieflix_flutter/bloc/movie_bloc/movie_bloc.dart';
import 'package:movieflix_flutter/bloc/movie_bloc/movie_event.dart';
import 'package:movieflix_flutter/bloc/movie_bloc/movie_state.dart';
import 'package:movieflix_flutter/bloc/person_bloc/person_bloc.dart';
import 'package:movieflix_flutter/bloc/person_bloc/person_event.dart';
import 'package:movieflix_flutter/bloc/person_bloc/person_state.dart';
import 'package:movieflix_flutter/repository/model/movie.dart';
import 'package:movieflix_flutter/repository/model/person.dart';
import 'package:movieflix_flutter/ui/category_screen/category_screen.dart';
import 'package:movieflix_flutter/ui/detail_movie_screen/detail_movie_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<MovieBloc>(
              create: (_) => MovieBloc()..add(MovieEventStarted(0, ''))),
          BlocProvider<PersonBloc>(
            create: (_) => PersonBloc()..add(PersonEventStarted()),
          )
        ],
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Icon(
              Icons.menu,
              color: Colors.black45,
            ),
            title: Center(
              child: Text(
                "Movie Flix",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'muli'),
              ),
            ),
            actions: [
              Container(
                margin: EdgeInsets.only(right: 15),
                child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage('assets/images/profile.png')),
              )
            ],
          ),
          body: _buildBody(context),
        ));
  }
}

Widget _buildBody(BuildContext context) {
  return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: constraints.maxHeight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
              if (state is MovieLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is MovieLoaded) {
                List<Movie> movies = state.movieList;
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CarouselSlider.builder(
                          itemCount: movies.length,
                          itemBuilder: (BuildContext context, int index, _) {
                            Movie movie = movies[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context, MaterialPageRoute(
                                      builder: (context) => DetailMovieScreen(movie: movie)
                                    ));
                              },
                              child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  ClipRRect(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "https://image.tmdb.org/t/p/original/${movie.backdropPath}",
                                      height:
                                          MediaQuery.of(context).size.height / 3,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Center(
                                        child: Icon(Icons.error),
                                      ),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.only(bottom: 15, left: 15),
                                      child: Text(
                                        movie.title!.toUpperCase(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            fontFamily: 'muli'),
                                        overflow: TextOverflow.ellipsis,
                                      ))
                                ],
                              ),
                            );
                          },
                          options: CarouselOptions(
                            enableInfiniteScroll: true,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 5),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            pauseAutoPlayOnTouch: true,
                            viewportFraction: 0.95,
                            enlargeCenterPage: true,
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            BuildWidgetCategory(),
                            SizedBox(height: 20),
                            Text(
                              "Trending persons on this week".toUpperCase(),
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontFamily: 'muli',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)
                            ),
                            SizedBox(height: 12),
                            Column(
                              children: [
                                BlocBuilder<PersonBloc, PersonState>(
                                  builder: (context, state) {
                                    if (state is PersonLoading) {
                                      return Center();
                                    } else if (state is PersonLoaded) {
                                      List<Person> personList = state.personList;
                                      return Container(
                                        height: 110,
                                        child: ListView.separated(
                                          itemBuilder: (context, index) {
                                            Person person = personList[index];
                                            return Container(
                                              child: Column(
                                                children: [
                                                  Card(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                100)),
                                                    elevation: 3,
                                                    child: ClipRRect(
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            "https://image.tmdb.org/t/p/w200${person.profilePath}",
                                                        imageBuilder: (context,
                                                            imageProvider) {
                                                          return Container(
                                                              width: 80,
                                                              height: 80,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius.circular(
                                                                      100),
                                                                ),
                                                                image:
                                                                    DecorationImage(
                                                                  image:
                                                                      imageProvider,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ));
                                                        },
                                                        placeholder:
                                                            (context, url) =>
                                                                Container(
                                                          width: 80,
                                                          height: 80,
                                                          child: Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          ),
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Container(
                                                          width: 80,
                                                          height: 80,
                                                          child: Center(
                                                            child:
                                                                Icon(Icons.error),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Center(
                                                      child: Text(
                                                        person.name!.toUpperCase(),
                                                        style: TextStyle(
                                                            color: Colors.black45,
                                                            fontSize: 8,
                                                            fontFamily: 'muli'),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Center(
                                                      child: Text(
                                                        person.knowForDepartment!
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                            color: Colors.black45,
                                                            fontSize: 8,
                                                            fontFamily: 'muli'),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                          separatorBuilder: (context, index) =>
                                              VerticalDivider(
                                            color: Colors.transparent,
                                            width: 5,
                                          ),
                                          itemCount: personList.length,
                                          scrollDirection: Axis.horizontal,
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
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
            })
          ],
        ),
      ),
    );
  });
}
