import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:news_c19/model/articles_response/Article.dart';
import 'article_full_screen.dart';

void showArticleDetailsSheet(BuildContext context, Article article) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => ArticleDetailsSheet(article: article),
  );
}

class ArticleDetailsSheet extends StatelessWidget {
  final Article article;
  const ArticleDetailsSheet({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            padding: REdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16.h,
              children: [
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        article.source?.name ?? "",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: CachedNetworkImage(
                    imageUrl: article.urlToImage ?? "",
                    height: 200.h,
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
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 18.sp),
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
                Row(
                  children: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.share_outlined)),
                    SizedBox(width: 8.w),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark_border)),
                  ],
                ),
                Text(
                  article.description ?? "",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ArticleFullScreen(article: article),
                        ),
                      );
                    },
                    child: const Text("View Full Article"),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      },
    );
  }
}