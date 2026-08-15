import 'package:flutter/material.dart';
import 'package:news_c19/core/remote/network/api_manager.dart';
import 'package:news_c19/model/sources_response/Source.dart';

class ArticlesViewModel extends ChangeNotifier{
  List<Source>? sourcesList;
  String? errorMessage;
  bool isLoading = false;
  fetchSources(String category)async{
    try{
      isLoading = true;
      notifyListeners();
      var sourcesResponse = await ApiManager.getSources(category);
      isLoading = false;
      if(sourcesResponse.status == "error"){
        // logic of error comes with response
        errorMessage = sourcesResponse.message;
      }else{
        // logic of success
        sourcesList = sourcesResponse.sources;
      }
      notifyListeners();
    }catch(e){
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
    }
  }
}