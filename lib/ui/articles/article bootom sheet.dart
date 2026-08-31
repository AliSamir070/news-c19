import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_c19/model/articles_response/Article.dart';

import 'article datalis.dart';

class ArticleBottomSheet extends StatelessWidget {
  final Article article;

  const ArticleBottomSheet({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: CachedNetworkImage(
              imageUrl: article.urlToImage ?? "",
              height: 180.h,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          SizedBox(height: 12.h),

          Text(
            article.title ?? "",
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.h),

          Text(
            article.description ?? "",
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 13.sp,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 16.h),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute
                      (builder: (context)=>ArticleDetailsScreen(article: article))


                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: const Text("View Full Article"),
            ),
          ),
        ],
      ),
    );
  }
}