import 'package:injectable/injectable.dart';
import 'package:news_c19/data/datasource/articles_dao.dart';
import 'package:news_c19/data/model/articles_response/Articles_response.dart';
import 'package:news_c19/repository/articles_repo.dart';
@Injectable(as: ArticlesRepo)
class ArticlesRepoImpl implements ArticlesRepo{
  ArticlesDao apiDao;
  ArticlesRepoImpl(this.apiDao);
  @override
  Future<ArticlesResponse> fetchArticles(String sourceId) {
    return apiDao.fetchArticles(sourceId);
  }

}