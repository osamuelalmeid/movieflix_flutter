import 'dart:html';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieflix_flutter/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:movieflix_flutter/bloc/movie_detail_bloc/movie_detail_event.dart';
import 'package:movieflix_flutter/bloc/movie_detail_bloc/movie_detail_state.dart';
import 'package:movieflix_flutter/repository/model/cast_list.dart';
import 'package:movieflix_flutter/repository/model/movie.dart';
import 'package:movieflix_flutter/repository/model/movie_detail.dart';
import 'package:movieflix_flutter/repository/model/screen_shot.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailMovieScreen extends StatelessWidget {
  const DetailMovieScreen({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MovieDetailBloc()..add(MovieDetailEventStarted(movie.id!)),
      child: WillPopScope(
          child: Scaffold(
            body: _buildDetailBody(context),
          ),
          onWillPop: () async => true),
    );
  }

  Widget _buildDetailBody(BuildContext context) {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
      if (state is MovieDetailLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is MovieDetailLoaded) {
        MovieDetail movieDetail = state.detail;
        return SingleChildScrollView(
          child: Stack(
            children: [
              ClipPath(
                child: ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://image.tmdb.org/t/p/original/${movieDetail.backdropPath}",
                    height: MediaQuery.of(context).size.height / 2,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Container(
                      child: Center(
                        child: Icon(Icons.error),
                      ),
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 120),
                    child: GestureDetector(
                      onTap: () async {
                        final youtubeUrl =
                            "https://www.youtube.com/embed/${movieDetail.trailerId}";
                        if (await canLaunch(youtubeUrl)) {
                          await launch(youtubeUrl);
                        }
                      },
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.play_circle_outlined,
                              color: Colors.yellow,
                              size: 65,
                            ),
                            Text(
                              movieDetail.title!.toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'muli',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 230,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Overview".toUpperCase(),
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontFamily: 'muli',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 35,
                          child: Text(
                            movieDetail.overview!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontFamily: 'muli'),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Release date".toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontFamily: 'muli',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  movieDetail.releaseDate!,
                                  style: TextStyle(
                                    color: Colors.yellow[800],
                                    fontFamily: 'muli',
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Run time".toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontFamily: 'muli',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  movieDetail.runtime!,
                                  style: TextStyle(
                                    color: Colors.yellow[800],
                                    fontFamily: 'muli',
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Budget".toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontFamily: 'muli',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  movieDetail.budget!,
                                  style: TextStyle(
                                    color: Colors.yellow[800],
                                    fontFamily: 'muli',
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Screenshots".toUpperCase(),
                          style: TextStyle(
                              color: Colors.black45,
                              fontFamily: 'muli',
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 155,
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              Screenshot image =
                                  movieDetail.movieImage!.backdrops[index];
                              return Container(
                                child: Card(
                                  elevation: 3,
                                  borderOnForeground: true,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: CachedNetworkImage(
                                      placeholder: (context, url) => Container(
                                        width: 260,
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                      imageUrl:
                                          "https://image.tmdb.org/t/p/w500${image.imagePath}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                VerticalDivider(
                              color: Colors.transparent,
                              width: 5,
                            ),
                            itemCount: movieDetail.movieImage!.backdrops.length,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text("Casts".toUpperCase(),
                            style: TextStyle(
                                color: Colors.black45,
                                fontFamily: 'muli',
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        Container(
                          height: 110,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              Cast cast = movieDetail.castList![index];
                              return Container(
                                  child: Column(
                                children: [
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    elevation: 3,
                                    child: ClipRRect(
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "https://image.tmdb.org/t/p/w200${cast.profilePath}",
                                        imageBuilder: (context, imageBuilder) {
                                          return Container(
                                            width: 80,
                                            height: 80,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(100)),
                                                image: DecorationImage(
                                                    image: imageBuilder,
                                                    fit: BoxFit.cover)),
                                          );
                                        },
                                        placeholder: (context, url) =>
                                            Container(
                                          width: 80,
                                          height: 80,
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) => Container(
                                          child: Center(
                                            child: Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Center(
                                      child: Text(
                                        cast.name!.toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 8,
                                          fontFamily: 'muli'
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Center(
                                      child: Text(
                                        cast.character!.toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 8,
                                          fontFamily: 'muli'
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ));
                            },
                            separatorBuilder: (context, index) =>
                                VerticalDivider(
                              color: Colors.transparent,
                              width: 5,
                            ),
                            itemCount: movieDetail.castList!.length,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(
                color: Colors.black45,
              ),
            ),
            Container(
              height: 500,
              child: Center(
                child: Text(
                  "Ops! Algo deu errado.",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            )
          ],
        );
      }
    });
  }
}
