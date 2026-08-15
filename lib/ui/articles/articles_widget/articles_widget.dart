import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_c19/core/remote/network/api_manager.dart';
import 'package:news_c19/core/resources/app_constants.dart';
import 'package:news_c19/model/category_model.dart';
import 'package:news_c19/ui/articles/articles_list/articles_list.dart';
import 'package:news_c19/ui/articles/articles_widget/view_model/articles_view_model.dart';
import 'package:provider/provider.dart';

class ArticlesWidget extends StatefulWidget {
  CategoryModel category;
  ArticlesWidget({required this.category});

  @override
  State<ArticlesWidget> createState() => _ArticlesWidgetState();
}

class _ArticlesWidgetState extends State<ArticlesWidget> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ArticlesViewModel()..fetchSources(widget.category.id),
      child: Consumer<ArticlesViewModel>(
          builder: (context, viewModel, child) {
            if(viewModel.isLoading){
              return Center(child: CircularProgressIndicator(),);
            }
            if(viewModel.errorMessage !=null){
              return Column(children: [
                Text(viewModel.errorMessage!),
                ElevatedButton(onPressed: () {
                 viewModel.fetchSources(widget.category.id);
                }, child: Text("Try Again"))
              ],);
            }
            if(viewModel.sourcesList!=null && viewModel.sourcesList!.isEmpty){
              return Center(child: Text("No Sources Found"),);
            }
            return DefaultTabController(
              length: viewModel.sourcesList?.length??0,
              child: Padding(
                padding: REdgeInsets.all(24),
                child: Column(
                  spacing: 24.h,
                  children: [
                    TabBar(
                        isScrollable: true,
                        tabs:viewModel.sourcesList?.map((source) => Tab(text: source.name,),).toList()??[]),
                    Expanded(
                      child: TabBarView(
                          children:viewModel.sourcesList?.map((source) => ArticlesList(source.id!),).toList()??[]
                      ),
                    )
                  ],
                ),
              ),
            );
          },
      ),
    );




    /*FutureBuilder(
        future: ApiManager.getSources(widget.category.id),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          if(snapshot.hasError){
            return Column(children: [
              Text("No Internet Connection"),
              ElevatedButton(onPressed: () {
                setState(() {

                });
              }, child: Text("Try Again"))
            ],);
          }
          var response = snapshot.data;
          if(response?.status=="error"){
            return Column(children: [
              Text(response?.message??""),
              ElevatedButton(onPressed: () {
                setState(() {

                });
              }, child: Text("Try Again"))
            ],);
          }
          return DefaultTabController(
            length: response?.sources?.length??0,
            child: Padding(
              padding: REdgeInsets.all(24),
              child: Column(
                spacing: 24.h,
                children: [
                  TabBar(
                      isScrollable: true,
                      tabs: response?.sources?.map((source) => Tab(text: source.name,),).toList()??[]),
                  Expanded(
                    child: TabBarView(
                        children:response?.sources?.map((source) => ArticlesList(source.id!),).toList()??[]
                    ),
                  )
                ],
              ),
            ),
          );
        },
    )*/;
  }
}
