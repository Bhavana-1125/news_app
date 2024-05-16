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

  @override
  void initState() {
    super.initState();
    newsBloc = BlocProvider.of<NewsBloc>(context);
    newsBloc.add( const FetchNewsEvent(page: 1));
  }

  @override
  Widget build(BuildContext context) {
    // var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;
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
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (scrollInfo is ScrollEndNotification &&
                            scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent) {
                          newsBloc.add(const FetchMoreNewsEvent());
                        }
                        return true;
                      },
                    child: ListView.builder(
                      itemCount: newsData.length,
                      itemBuilder: (context, index) {
                        final article = newsData[index];
                        return CustomArticleCard(article: article);
                      },
                    ),
                  ),
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
}





