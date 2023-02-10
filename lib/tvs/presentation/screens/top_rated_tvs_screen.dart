import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movies/tvs/presentation/controller/tvs_bloc.dart';
import 'package:movies/tvs/presentation/controller/tvs_events.dart';
import 'package:movies/tvs/presentation/controller/tvs_states.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/network/api_constances.dart';
import '../../../core/services/services_locator.dart';
import '../../../core/utils/app_string.dart';

class TopRatedTvsScreen extends StatelessWidget {
  const TopRatedTvsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TvsBloc>()..add(GetTopRatedTvsEvents()),
      child: BlocBuilder<TvsBloc, TvsStates>(
        buildWhen: (previous, current) =>
            previous.topRatedTvsState != current.topRatedTvsState,
        builder: (BuildContext context, state) {
          final size = MediaQuery.of(context).size;
          final topRatedTvs = state.topRatedTvs;
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back_ios)),
              centerTitle: true,
              title:  const Text(AppString.topRatedTvs),
              backgroundColor: Colors.black12,
            ),
            body: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: topRatedTvs.length,
                itemBuilder: (context, index) {
                  final tv = topRatedTvs[index];
                  return Container(
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.all(5.0),
                    height: size.height * .19,
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          child: CachedNetworkImage(
                            width: size.width * .24,
                            height: size.height * .19,
                            fit: BoxFit.cover,
                            imageUrl: ApiConstance.imageUrl(tv.backdropPath),
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[850]!,
                              highlightColor: Colors.grey[800]!,
                              child: Container(
                                width: size.width * .24,
                                height: size.height * .19,
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
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: size.width * .66,
                              child: Text(
                                tv.name,
                                style: const TextStyle(fontSize: 18),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(3),
                                  height: size.height * .025,
                                  width: size.width * .1,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(3.0),
                                  ),
                                  child: Text(
                                    tv.airDate.split('-')[0],
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 17,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(tv.voteAverage.toString()),
                              ],
                            ),
                            SizedBox(
                              width: size.width * .66,
                              child: Text(
                                tv.overview,
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}