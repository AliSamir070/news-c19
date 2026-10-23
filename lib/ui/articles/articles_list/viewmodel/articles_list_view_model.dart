import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news_c19/core/remote/network/api_manager.dart';
import 'package:news_c19/repository/articles_repo.dart';

import '../../../../data/model/articles_response/Article.dart';
@injectable
class ArticlesListViewModel extends Cubit<ArticlesListStates>{
  ArticlesListViewModel(this.articlesRepo):super(ArticlesListLoadingState());
  ArticlesRepo articlesRepo;
  fetchArticles(String sourceId)async{
    try{
      // loading
      emit(ArticlesListLoadingState());
      var response = await articlesRepo.fetchArticles(sourceId);
      if(response.status == "error"){
        // logic of server error
        emit(ArticlesListErrorState(response.message!));
      }else{
        // logic of success articles list
        emit(ArticlesListSuccessState(response.articles??[]));
      }
    }catch(e){
      // logic of connection error
      emit(ArticlesListErrorState("No Internet Connection"));
    }
  }
}

sealed class ArticlesListStates{}

class ArticlesListLoadingState extends ArticlesListStates{}
class ArticlesListSuccessState extends ArticlesListStates{
  List<Article> articlesList;
  ArticlesListSuccessState(this.articlesList);
}
class ArticlesListErrorState extends ArticlesListStates{
  String message;
  ArticlesListErrorState(this.message);
}
