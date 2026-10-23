import 'package:news_c19/data/model/articles_response/Articles_response.dart';

abstract interface class ArticlesDao {
  Future<ArticlesResponse> fetchArticles(String sourceId);
}