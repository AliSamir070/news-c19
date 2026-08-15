import 'package:flutter/material.dart';
import 'package:news_c19/core/remote/network/api_manager.dart';
import 'package:news_c19/model/articles_response/Article.dart';

class ArticlesListViewModel extends ChangeNotifier {
  String? errorMessage;
  List<Article>? articlesList;
  bool isLoading = false;
  fetchArticlesList(String sourceId)async{
     try{
       isLoading = true;
       notifyListeners();
       var response = await ApiManager.getArticles(sourceId);
       isLoading = false;
       if(response.status == "error"){
         // return server error
         errorMessage = response.message;
       }else{
         // success : list of articles
        articlesList =  response.articles;
       }
       notifyListeners();
     }catch(e){
       isLoading = false;
       errorMessage = e.toString();
       notifyListeners();
     }
  }
}