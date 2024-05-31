import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news_bloc.dart';
import 'package:news_app/bloc/news_state.dart';
import 'package:news_app/models/article_data_model.dart';
import 'package:news_app/widgets/article_card.dart';

import '../bloc/news_event.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late NewsBloc newsBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    newsBloc = BlocProvider.of<NewsBloc>(context);
    newsBloc.add(FetchNewsEvent());
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >
        _scrollController.position.maxScrollExtent * 0.7) {
      newsBloc.add(const FetchMoreNewsEvent());
    }
  }

  Future<void> _refresh() async {
    newsBloc.add(FetchNewsEvent());
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state is NewsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is NewsSuccessState) {
          final List<Articles> newsData = state.newsData.articles!;
          return SafeArea(
            child: Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Flutter News".toUpperCase(),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                        onRefresh: _refresh,
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: newsData.length + 1,
                          itemBuilder: (context, index) {
                            if (index < newsData.length) {
                              final article = newsData[index];
                              //Articles article = newsBloc.loadedArticles![index];
                              return CustomArticleCard(article: article);
                            } else {
                              return const Center(
                                child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    child: CircularProgressIndicator()),
                              );
                            }
                          },
                        )),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: Text("Failed to load data"));
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
