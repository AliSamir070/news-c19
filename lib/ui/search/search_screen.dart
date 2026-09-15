import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_c19/core/remote/network/api_manager.dart';
import 'package:news_c19/model/articles_response/Article.dart';
import 'package:news_c19/ui/articles/article_item.dart';
import 'package:news_c19/ui/search/search_screen.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Article> _results = [];
  bool _isLoading = false;
  bool _searched = false;
  String? _errorMessage;

  Future<void> _search(String query) async {
    if (query.trim().isEmpty) return;
    setState(() {
      _isLoading = true;
      _searched = true;
      _errorMessage = null;
    });
    var response = await ApiManager.searchArticles(query.trim());
    setState(() {
      _isLoading = false;
      if (response == null) {
        _errorMessage = "No Internet Connection";
        _results = [];
      } else if (response.status == "error") {
        _errorMessage = response.message ?? "Something went wrong";
        _results = [];
      } else {
        _results = response.articles ?? [];
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          autofocus: true,
          onSubmitted: _search,
          onChanged: (value) => setState(() {}),
          decoration: InputDecoration(
            hintText: "Search articles...",
            border: InputBorder.none,
            suffixIcon: _controller.text.isEmpty
                ? null
                : IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                _controller.clear();
                setState(() {
                  _results = [];
                  _searched = false;
                });
              },
            ),
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_errorMessage != null) {
      return Center(child: Text(_errorMessage!));
    }
    if (!_searched) {
      return const Center(child: Text("Search for news articles"));
    }
    if (_results.isEmpty) {
      return const Center(child: Text("No articles found"));
    }
    return ListView.separated(
      padding: REdgeInsets.all(24),
      itemBuilder: (context, index) => ArticleItem(_results[index]),
      separatorBuilder: (context, index) => SizedBox(height: 24.h),
      itemCount: _results.length,
    );
  }
}