import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:news_c19/core/resources/app_constants.dart';
import 'package:news_c19/model/articles_response/Articles_response.dart';
import 'package:news_c19/model/sources_response/Sources_response.dart';

class ApiManager {
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://newsapi.org",
      queryParameters: {"apiKey": AppConstants.apiKey},
    ),
  );

  static Future<SourcesResponse?> getSources(String category) async {
    try {
      var response = await dio.get(
        "/v2/top-headlines/sources",
        queryParameters: {"category": category},
      );
      SourcesResponse sourcesResponse = SourcesResponse.fromJson(response.data);
      return sourcesResponse;
    } on DioException catch (e) {
      if (kDebugMode) {
        print("Status code: ${e.response?.statusCode}");
        print("Error: ${e.message}");
        print("Response: ${e.response?.data}");
      }

      return null;
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }

      return null;
    }
  }

  //sources=bbc-sport

  static Future<ArticlesResponse?> getArticles(String sourceId) async {
    try {
      var response = await dio.get(
        "/v2/everything",
        queryParameters: {"sources": sourceId},
      );
      ArticlesResponse articlesResponse = ArticlesResponse.fromJson(
        response.data,
      );
      return articlesResponse;
    } on DioException catch (e) {
      if (kDebugMode) {
        print("Status code: ${e.response?.statusCode}");
        print("Error: ${e.message}");
        print("Response: ${e.response?.data}");
      }

      return null;
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }

      return null;
    }
  }

  static Future<ArticlesResponse?> search(String query) async {
    if (query.trim().isEmpty) return null;

    try {
      final response = await dio.get(
        "/v2/everything",
        queryParameters: {"q": query.trim(), "sortBy": "popularity"},
      );

      return ArticlesResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (kDebugMode) {
        print("Status code: ${e.response?.statusCode}");
        print("Error: ${e.message}");
        print("Response: ${e.response?.data}");
      }

      return null;
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }

      return null;
    }
  }
}
