import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_movies/core/helpers/date_helper.dart';
import 'package:the_movies/shared/models/tv_series.dart';
import 'package:the_movies/shared/widgets/error_image_widget.dart';
import 'package:the_movies/shared/widgets/list_image_shimmer.dart';

class ListItemTv extends StatelessWidget {
  final TvSeries data;
  final Function() onTapWatchList;

  const ListItemTv(
      {Key? key, required this.data, required this.onTapWatchList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: 140,
        child: Row(
          children: [
            SizedBox(
              height: 75,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  imageUrl: 'https://image.tmdb.org/t/p/w500${data.posterPath}',
                  width: 50,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const ListImageShimmer(),
                  errorWidget: (context, url, error) => const ErrorImageWidget(),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name ?? '-',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Text(
                      DateHelper.parseDate(data.firstAirDate),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: onTapWatchList,
              child: FaIcon(
                data.watchList
                    ? FontAwesomeIcons.solidBookmark
                    : FontAwesomeIcons.bookmark,
                size: 18,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
