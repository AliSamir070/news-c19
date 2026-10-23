import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news_c19/core/remote/network/api_manager.dart';
import 'package:news_c19/repository/sources_repo.dart';

import '../../../../data/model/sources_response/Source.dart';
@injectable
class ArticlesViewModel extends Cubit<ArticlesStates>{
  ArticlesViewModel(this.sourcesRepo):super(ArticlesLoadingState());
  SourcesRepo sourcesRepo;
  fetchSources(String category)async{
    try{
      // loading logic
      emit(ArticlesLoadingState());
      var response = await sourcesRepo.fetchSources(category);
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
