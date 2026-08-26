import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_c19/core/remote/network/api_manager.dart';
import 'package:news_c19/core/resources/strings_manager.dart';
import 'package:news_c19/model/articles_response/Article.dart';
import 'package:news_c19/ui/articles/article_item.dart';

class ArticlesList extends StatefulWidget {
  String sourceId;
  ArticlesList(this.sourceId);

  @override
  State<ArticlesList> createState() => _ArticlesListState();
}

class _ArticlesListState extends State<ArticlesList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiManager.getArticles(widget.sourceId),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          if(snapshot.hasError){
            return Column(children: [
              Text("No Internet Connection"),
              ElevatedButton(onPressed: () {
                setState(() {

                });
              }, child: Text("Try Again"))
            ],);
          }
          var articlesResponse = snapshot.data!;
          if(articlesResponse.status=="error"){
            return Column(children: [
              Text(articlesResponse.message??""),
              ElevatedButton(onPressed: () {
                setState(() {

                });
              }, child: Text("Try Again"))
            ],);
          }
          var articlesList = articlesResponse.articles??[];
          if(articlesList.isEmpty){
            return Center(child: Text("No articles found"),);
          }
          return ListView.separated(
              itemBuilder: (context, index) => ArticleItem(articlesList[index],() {
                showArticleDetails(context, articlesList[index]);
              },),
              separatorBuilder: (context, index) => SizedBox(height: 24.h,),
              itemCount: articlesList.length
          );
        },);
  }

  void showArticleDetails(BuildContext context, Article article) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: REdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 16,
        ),
        padding: REdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: CachedNetworkImage(
                imageUrl: article.urlToImage ?? "",
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              article.content ?? article.description ?? "",
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 14.sp,
                  ),
            ),
            SizedBox(height: 8.h),
            ElevatedButton(
              onPressed: () {
                //SSSS
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                foregroundColor: Theme.of(context).colorScheme.primary,
                padding: REdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                textStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              child: const Text(StringsManager.viewFullArticle),
            ),
          ],
        ),
      ),
    );
  }
}

