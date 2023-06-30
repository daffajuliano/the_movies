import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_movies/shared/models/tv_series.dart';
import 'package:the_movies/shared/widgets/error_image_widget.dart';
import 'package:the_movies/shared/widgets/poster_image_shimmer.dart';

class ListPosterTv extends StatelessWidget {
  final TvSeries data;

  const ListPosterTv({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: 140,
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: 'https://image.tmdb.org/t/p/w500${data.posterPath}',
                  width: 140,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const PosterImageShimmer(),
                  errorWidget: (context, url, error) =>
                      const ErrorImageWidget(isPoster: true),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  data.name ?? '-',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.solidStar,
                    size: 13,
                    color: Colors.yellow[700],
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '${data.voteAverage} ',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '(${data.voteCount})',
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
