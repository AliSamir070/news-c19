import 'package:injectable/injectable.dart';
import 'package:news_c19/core/remote/network/api_manager.dart';
import 'package:news_c19/data/datasource/articles_dao.dart';
import 'package:news_c19/data/model/articles_response/Articles_response.dart';
@Injectable(as: ArticlesDao)
class ArticlesApiDaoImpl implements ArticlesDao{
  ApiManager apiManager;
  ArticlesApiDaoImpl(this.apiManager);
  @override
  Future<ArticlesResponse> fetchArticles(String sourceId) async{
    var response = await apiManager.getArticles(sourceId);
    return response;
  }

}