import 'package:news_c19/data/model/sources_response/Sources_response.dart';

abstract interface class SourcesDao {
  Future<SourcesResponse> fetchSources(String categoryId);
}