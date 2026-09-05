import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/remote/network/api_manager.dart';
import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/colors_manager.dart';
import '../../articles/article_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchController;
  late final FocusNode _searchFocusNode;

  Timer? _debounce;
  Future? _searchFuture;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();

    final query = value.trim();

    if (query.isEmpty || query.length < 2) {
      setState(() {
        _searchFuture = null;
      });
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 700), () {
      if (!mounted) return;

      setState(() {
        _searchFuture = ApiManager.search(query);
      });
    });
  }

  void _retrySearch() {
    setState(() {
      _searchFuture = ApiManager.search(_searchController.text);
    });
  }

  void _clearSearch() {
    _debounce?.cancel();
    _searchController.clear();
    _searchFocusNode.unfocus();

    setState(() {
      _searchFuture = null;
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              TextFormField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                focusNode: _searchFocusNode,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  prefixIcon: UnconstrainedBox(
                    child: SvgPicture.asset(
                      AssetsManager.search,
                      width: 24.w,
                      height: 24.h,
                    ),
                  ),
                  suffixIcon: UnconstrainedBox(
                    child: GestureDetector(
                      onTap: _clearSearch,
                      child: Icon(
                        Icons.clear,
                        size: 24.r,
                        color: ColorsManager.lightPrimaryColor,
                      ),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                style: TextStyle(
                  color: ColorsManager.lightPrimaryColor,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: _searchFuture == null
                    ? const Center(
                        child: Text(
                          'Start searching to find articles you may like',
                        ),
                      )
                    : FutureBuilder(
                        future: _searchFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (snapshot.hasError) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('No Internet Connection'),
                                ElevatedButton(
                                  onPressed: _retrySearch,
                                  child: const Text('Try Again'),
                                ),
                              ],
                            );
                          }

                          if (snapshot.data == null) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('No articles found'),
                                ElevatedButton(
                                  onPressed: _retrySearch,
                                  child: const Text('Try Again'),
                                ),
                              ],
                            );
                          }

                          final articlesResponse = snapshot.data!;

                          if (articlesResponse.status == 'error') {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(articlesResponse.message ?? ''),
                                ElevatedButton(
                                  onPressed: _retrySearch,
                                  child: const Text('Try Again'),
                                ),
                              ],
                            );
                          }

                          final articlesList = articlesResponse.articles ?? [];

                          if (articlesList.isEmpty) {
                            return const Center(
                              child: Text('No articles found'),
                            );
                          }

                          return ListView.separated(
                            itemBuilder: (context, index) =>
                                ArticleItem(articlesList[index]),
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 24.h),
                            itemCount: articlesList.length,
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
