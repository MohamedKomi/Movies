import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/tvs/presentation/controller/tvs_bloc.dart';
import 'package:movies/tvs/presentation/controller/tvs_states.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/network/api_constances.dart';
import '../../../core/utils/request_states.dart';
import '../screens/tv_details_screen.dart';

class PopularTvsComponent extends StatelessWidget {
  const PopularTvsComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return BlocBuilder<TvsBloc, TvsStates>(

        buildWhen: (previous, current) =>
            previous.popularTvsState != current.popularTvsState,
        builder: (BuildContext context, state) {

          switch (state.popularTvsState) {
            case RequestState.loading:
              return  SizedBox(
                height: size.height*.2 ,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );

            case RequestState.loaded:
              return FadeIn(
                duration: const Duration(microseconds: 500),
                child: SizedBox(
                  height: size.height*.2 ,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: state.popularTvs.length,
                    itemBuilder: (context, index) {
                      final tv = state.popularTvs[index];
                      return Container(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TvDetailsScreen(id: tv.id,currentSeason: 1,),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                            child: CachedNetworkImage(
                              width:size.height*.14,
                              fit: BoxFit.cover,
                              imageUrl: ApiConstance.imageUrl(tv.backdropPath),
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey[850]!,
                                highlightColor: Colors.grey[800]!,
                                child: Container(
                                  height:size.height*.2 ,
                                  width: size.height*.14,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );

            case RequestState.error:
              return SizedBox(
                height: size.height*.2 ,
                child: Center(
                  child: Text(state.popularTvsMessage),
                ),
              );
          }
        });
  }
}
