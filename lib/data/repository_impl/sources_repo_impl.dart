import 'package:injectable/injectable.dart';
import 'package:news_c19/data/datasource/sources_dao.dart';
import 'package:news_c19/data/model/sources_response/Sources_response.dart';
import 'package:news_c19/repository/sources_repo.dart';
@Injectable(as: SourcesRepo)
class SourcesRepoImpl implements SourcesRepo{
  SourcesDao apiDao;
  SourcesRepoImpl(this.apiDao);
  @override
  Future<SourcesResponse> fetchSources(String categoryId) {
    return apiDao.fetchSources(categoryId);
  }

}