import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/core/network/api_constances.dart';
import 'package:movies/core/utils/app_string.dart';

import 'package:movies/tvs/presentation/controller/tv_details_bloc.dart';
import 'package:movies/tvs/presentation/controller/tv_details_events.dart';
import 'package:movies/tvs/presentation/controller/tv_details_states.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/request_states.dart';
import '../../domain/entities/tv_genres.dart';

class TvDetailsScreen extends StatefulWidget {
  final int id;
  final int currentSeason;

  const TvDetailsScreen(
      {Key? key, required this.id, required this.currentSeason})
      : super(key: key);

  @override
  State<TvDetailsScreen> createState() => _TvDetailsScreenState();
}

class _TvDetailsScreenState extends State<TvDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = const [
      Text(AppString.episodes),
      Text(AppString.moreLikeThis),
    ];
    return BlocProvider(
        create: (BuildContext context) =>
        sl<TvDetailsBloc>()
          ..add(GetTvDetailsEvents(widget.id))..add(
            GetTvRecommendationsEvents(widget.id))..add(
            GetTvEpisodesEvents(widget.id, widget.currentSeason)),
        child: BlocBuilder<TvDetailsBloc, TvDetailsStates>(
          builder: (context, state) {
            final episodes = state.tvEpisodes;
            var size = MediaQuery
                .of(context)
                .size;
            switch (state.tvDetailsState) {
              case RequestState.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case RequestState.loaded:
                {
                  int nomOfSeasons = state.tvDetails!.numberOfSeasons;

                  List<int> seasons = [];

                  for (int i = 1; i <= nomOfSeasons; i++) {
                    seasons.add(i);
                  }
                  return Scaffold(
                    body: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              FadeIn(
                                duration: const Duration(milliseconds: 500),
                                child: ShaderMask(
                                  shaderCallback: (rect) {
                                    return const LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black,
                                        Colors.black,
                                        Colors.transparent,
                                      ],
                                      stops: [0.0, 0.5, 1.0, 1.0],
                                    ).createShader(
                                      Rect.fromLTRB(
                                          0.0, 0.0, rect.width, rect.height),
                                    );
                                  },
                                  blendMode: BlendMode.dstIn,
                                  child: CachedNetworkImage(
                                    width: size.width,
                                    height: size.height * .3,
                                    imageUrl: ApiConstance.imageUrl(
                                        state.tvDetails!.backdropPath),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: size.height * 0.05,
                                child: IconButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  icon: const Icon(Icons.arrow_back_ios),
                                ),
                              ),
                            ],
                          ),
                          FadeInUp(
                            from: 20,
                            duration: const Duration(milliseconds: 500),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(state.tvDetails!.name,
                                      style: GoogleFonts.poppins(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1.2,
                                      )),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 2.0,
                                          horizontal: 8.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[800],
                                          borderRadius:
                                          BorderRadius.circular(4.0),
                                        ),
                                        child: Text(
                                          state.tvDetails!.airDate
                                              .split('-')[0],
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16.0),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 20.0,
                                          ),
                                          const SizedBox(width: 4.0),
                                          Text(
                                            (state.tvDetails!.voteAverage / 2)
                                                .toStringAsFixed(1),
                                            style: const TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 1.2,
                                            ),
                                          ),
                                          const SizedBox(width: 4.0),
                                          Text(
                                            '(${state.tvDetails!.voteAverage})',
                                            style: const TextStyle(
                                              fontSize: 1.0,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 1.2,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 16.0),
                                      Text(
                                        _showDuration(state.tvDetails!.runtime),
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: size.height * .02),
                                  Text(
                                    state.tvDetails!.overview,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    '${AppString.genres}: ${_showGenres(
                                        state.tvDetails!.genres)}',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * .03,
                          ),
                          DefaultTabController(
                              length: 2,
                              child: Column(
                                children: [
                                  SizedBox(
                                    child: TabBar(
                                        labelPadding:
                                        const EdgeInsets.symmetric(
                                            vertical: 15),
                                        physics: const BouncingScrollPhysics(),
                                        unselectedLabelColor: Colors.white70,
                                        indicatorColor: Colors.red,
                                        indicatorWeight: 3,
                                        tabs: tabs),
                                  ),
                                  SizedBox(
                                    height: size.height * .01,
                                  ),
                                  SizedBox(
                                    height: size.height * .8,
                                    child: TabBarView(
                                      children: [
                                        SizedBox(
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    right: 10, left: 10),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        10),
                                                    color:
                                                    Colors.grey.shade800),
                                                width: size.width * .9,
                                                child: DropdownButton(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        10),
                                                    value: widget.currentSeason,
                                                    isExpanded: true,
                                                    underline: Container(),
                                                    items: seasons
                                                        .map<
                                                        DropdownMenuItem<
                                                            int>>((int val) =>
                                                        DropdownMenuItem<
                                                            int>(
                                                            value: val,
                                                            child: Text(
                                                                '${AppString
                                                                    .season} $val')))
                                                        .toList(),
                                                    onChanged: (x) {
                                                      setState(() {
                                                        Navigator.of(context)
                                                            .pushReplacement(
                                                          MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                TvDetailsScreen(
                                                                    id: widget
                                                                        .id,
                                                                    currentSeason:
                                                                    x!),
                                                          ),
                                                        );
                                                      });
                                                    }),
                                              ),
                                              SizedBox(
                                                height: size.height * .01,
                                              ),
                                              SizedBox(
                                                height: size.height * .7,
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                  Axis.vertical,
                                                  physics:
                                                  const BouncingScrollPhysics(),
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                    Axis.vertical,
                                                    shrinkWrap: true,
                                                    physics:
                                                    const BouncingScrollPhysics(),
                                                    itemCount: episodes.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final episode =
                                                      episodes[index];
                                                      return Container(

                                                        padding:
                                                        const EdgeInsets
                                                            .all(10.0),
                                                        margin: const EdgeInsets
                                                            .all(5.0),
                                                        decoration:
                                                        BoxDecoration(
                                                          color: Theme
                                                              .of(
                                                              context)
                                                              .scaffoldBackgroundColor,
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(15),
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius: const BorderRadius
                                                                      .all(
                                                                      Radius
                                                                          .circular(
                                                                          8.0)),
                                                                  child:
                                                                  CachedNetworkImage(
                                                                    width:
                                                                    size.width *
                                                                        .3,
                                                                    height:
                                                                    size
                                                                        .height *
                                                                        .1,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    imageUrl: ApiConstance
                                                                        .imageUrl(
                                                                        episode
                                                                            .stillPath),
                                                                    placeholder: (
                                                                        context,
                                                                        url) =>
                                                                        Shimmer
                                                                            .fromColors(
                                                                          baseColor:
                                                                          Colors
                                                                              .grey[850]!,
                                                                          highlightColor:
                                                                          Colors
                                                                              .grey[800]!,
                                                                          child:
                                                                          Container(
                                                                            height:
                                                                            size
                                                                                .height *
                                                                                1.9,
                                                                            width:
                                                                            size
                                                                                .height *
                                                                                .2,
                                                                            decoration:
                                                                            BoxDecoration(
                                                                              color:
                                                                              Colors
                                                                                  .black,
                                                                              borderRadius:
                                                                              BorderRadius
                                                                                  .circular(
                                                                                  8.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                    errorWidget: (
                                                                        context,
                                                                        url,
                                                                        error) =>
                                                                    const Icon(
                                                                        Icons
                                                                            .error),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width: 10),
                                                                Column(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                            '${episode
                                                                                .episodeNumber}.'),
                                                                        SizedBox(
                                                                          width:
                                                                          size
                                                                              .width *
                                                                              .52,
                                                                          child:
                                                                          Text(
                                                                            episode
                                                                                .name,
                                                                            style:
                                                                            const TextStyle(
                                                                                fontSize: 15),
                                                                            overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Text(
                                                                        episode
                                                                            .airDate,
                                                                        style: const TextStyle(
                                                                            color:
                                                                            Colors
                                                                                .grey)),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 8,
                                                            ),
                                                            Text(
                                                              episode.overView,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        GridView.builder(

                                          physics:
                                          const BouncingScrollPhysics(),
                                          itemCount:
                                          state.tvRecommendations.length,
                                          itemBuilder: (context, index) {
                                            final recommendation =
                                            state.tvRecommendations[index];
                                            return FadeInUp(
                                              from: 20,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              child: ClipRRect(
                                                borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(4.0)),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                  ApiConstance.imageUrl(
                                                      recommendation
                                                          .backdropPath!),
                                                  placeholder: (context, url) =>
                                                      Shimmer.fromColors(
                                                        baseColor:
                                                        Colors.grey[850]!,
                                                        highlightColor:
                                                        Colors.grey[800]!,
                                                        child: Container(
                                                          height: size.height *
                                                              .2,
                                                          width: size.width *
                                                              .3,
                                                          decoration: BoxDecoration(
                                                            color: Colors.black,
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                          ),
                                                        ),
                                                      ),
                                                  errorWidget: (context, url,
                                                      error) =>
                                                  const Icon(Icons.error),
                                                  height: size.height * .2,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            );
                                          },
                                          gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                            mainAxisSpacing: 8.0,
                                            crossAxisSpacing: 8.0,
                                            childAspectRatio: 0.7,
                                            crossAxisCount: 3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                  );
                }
              case RequestState.error:
                return Center(
                  child: Text(state.tvDetailsMessage),
                );
            }
          },
        ));
  }
}

String _showGenres(List<TvGenres> genres) {
  String result = '';
  for (var genre in genres) {
    result += '${genre.name}, ';
  }

  if (result.isEmpty) {
    return result;
  }

  return result.substring(0, result.length - 2);
}

String _showDuration(int runtime) {
  final int hours = runtime ~/ 60;
  final int minutes = runtime % 60;

  if (hours > 0) {
    return '${hours}h ${minutes}m';
  } else {
    return '${minutes}m';
  }
}
