import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:news_c19/model/articles_response/Article.dart';

class ArticleFullScreen extends StatelessWidget {
  final Article article;
  const ArticleFullScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.source?.name ?? ""),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share_outlined)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark_border)),
        ],
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16.h,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: CachedNetworkImage(
                imageUrl: article.urlToImage ?? "",
                height: 220.h,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  color: Theme.of(context).colorScheme.primary,
                  size: 40.sp,
                ),
              ),
            ),
            Text(
              article.title ?? "",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 20.sp),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "By : ${article.author ?? ""}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Text(
                  article.publishedAt != null
                      ? timeago.format(DateTime.parse(article.publishedAt!))
                      : "",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            Text(
              article.description ?? "",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              article.content ?? "",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}