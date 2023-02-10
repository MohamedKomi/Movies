import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/tvs/presentation/controller/tvs_bloc.dart';
import 'package:movies/tvs/presentation/controller/tvs_states.dart';
import 'package:movies/tvs/presentation/screens/tv_details_screen.dart';

import '../../../core/network/api_constances.dart';
import '../../../core/utils/app_string.dart';
import '../../../core/utils/request_states.dart';

class OnTheAirTvComponent extends StatelessWidget {
  const OnTheAirTvComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return BlocBuilder<TvsBloc, TvsStates>(
        buildWhen: (previous, current) =>
            previous.onTheAirTvsState != current.onTheAirTvsState,
        builder: (BuildContext context, state) {
          switch (state.onTheAirTvsState) {
            case RequestState.loading:
              return  SizedBox(
                height:size.height*.45 ,
                child:const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case RequestState.loaded:
              return FadeIn(
                  duration: const Duration(microseconds: 500),
                  child: CarouselSlider(
                    options: CarouselOptions(
                        height: size.height*.45 ,
                        viewportFraction: 1.0,
                        onPageChanged: (index, reason) {}),
                    items: state.onTheAirTvs.map(
                      (item) {
                        return GestureDetector(
                          key: const Key('openTvMinimalDetail'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TvDetailsScreen(
                                  id: item.id,currentSeason: 1,

                                ),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              ShaderMask(
                                shaderCallback: (rect) {
                                  return const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      // fromLTRB
                                      Colors.transparent,
                                      Colors.black,
                                      Colors.black,
                                      Colors.transparent,
                                    ],
                                    stops: [0, 0.3, 0.5, 1],
                                  ).createShader(
                                    Rect.fromLTRB(
                                        0, 0, rect.width, rect.height),
                                  );
                                },
                                blendMode: BlendMode.dstIn,
                                child: CachedNetworkImage(
                                  height: 560.0,
                                  imageUrl:
                                      ApiConstance.imageUrl(item.backdropPath),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.circle,
                                            color: Colors.redAccent,
                                            size: 16.0,
                                          ),
                                          SizedBox(width: 4.0),
                                          Text(
                                            AppString.onTheAir,
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16.0),
                                      child: Text(
                                        item.name,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 24, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ).toList(),
                  ));
            case RequestState.error:
              return SizedBox(
                height: size.height*.45,
                child: Center(
                  child: Text(
                    state.onTheAirTvsMessage,
                  ),
                ),
              );
          }
        });
  }
}
