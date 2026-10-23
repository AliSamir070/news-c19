import 'package:injectable/injectable.dart';
import 'package:news_c19/core/remote/network/api_manager.dart';
import 'package:news_c19/data/datasource/sources_dao.dart';
import 'package:news_c19/data/model/sources_response/Sources_response.dart';
@Injectable(as: SourcesDao)
class SourcesApiDaoImpl implements SourcesDao{
  ApiManager apiManager;
  SourcesApiDaoImpl(this.apiManager);
     // coupling // constructor injection

  @override
  Future<SourcesResponse> fetchSources(String categoryId) async{
    var response = await apiManager.getSources(categoryId);
    return response;
  }

}