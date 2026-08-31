import 'package:flutter/material.dart';

import '../../../core/remote/network/api_manager.dart';
import '../../../model/articles_response/Articles_response.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'اSearch...',
            border: InputBorder.none,
          ),
          onSubmitted: (value) {
            setState(() {
              searchQuery = value.trim();
            });
          },
        ),
      ),

      body: searchQuery.isEmpty
          ? const Center(
        child: Text(''),
      )
          : FutureBuilder<ArticlesResponse?>(
        future: ApiManager.searchArticles(searchQuery),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError || snapshot.data == null) {
            return const Center(
              child: Text('error'),
            );
          }

          var articles = snapshot.data?.articles ?? [];

          if (articles.isEmpty) {
            return const Center(
              child: Text('No articles found'),
            );
          }

          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: const EdgeInsets.all(10),

                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    articles[index].urlToImage ?? '',
                    width: 100,
                    height: 70,
                    fit: BoxFit.cover,

                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 100,
                        height: 70,
                        color: Colors.grey,
                        child: const Icon(
                          Icons.image,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),

                title: Text(
                  articles[index].title ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                subtitle: Text(
                  articles[index].description ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}