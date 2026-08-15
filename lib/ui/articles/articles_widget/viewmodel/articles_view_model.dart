import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_c19/core/remote/network/api_manager.dart';
import 'package:news_c19/model/sources_response/Source.dart';

class ArticlesViewModel extends Cubit<ArticlesStates>{
  ArticlesViewModel():super(ArticlesLoadingState());

  fetchSources(String category)async{
    try{
      // loading logic
      emit(ArticlesLoadingState());
      var response = await ApiManager.getSources(category);
      if(response.status=="error"){
        // logic of error comes with response
        emit(ArticlesErrorState(response.message!));
      }else{
        // logic of success sources list
        emit(ArticlesSuccessState(response.sources??[]));
      }
    }catch(e){
      // logic of connection error
      emit(ArticlesErrorState("No Internet Connection"));
    }
  }
}

sealed class ArticlesStates{}
class ArticlesLoadingState extends ArticlesStates{}
class ArticlesSuccessState extends ArticlesStates{
  List<Source> sourcesList;
  ArticlesSuccessState(this.sourcesList);
}
class ArticlesErrorState extends ArticlesStates{
  String message;
  ArticlesErrorState(this.message);
}
