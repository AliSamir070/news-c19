import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_c19/core/remote/network/api_manager.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/resources/app_constants.dart';
import '../../core/resources/strings_manager.dart';
import '../../model/articles_response/Article.dart';

class ArticleBottomSheet extends StatelessWidget {
  const ArticleBottomSheet({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(8.r),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: CachedNetworkImage(
                imageUrl: article.urlToImage ?? "",
                height: 220.h,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  color: Theme.of(context).colorScheme.primary,
                  size: 40.sp,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              article.title ?? "",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              article.description ?? "",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8.h),
            ElevatedButton(
              onPressed: () async {
                await launchUrl(
                  Uri.parse(article.url ?? ""),
                  mode: .inAppWebView,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                minimumSize: Size(double.infinity, 56.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              child: Text(
                StringsManager.viewAllArticle,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
