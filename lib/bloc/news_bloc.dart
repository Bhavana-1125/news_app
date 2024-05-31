import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news_state.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/models/article_data_model.dart';
import 'dart:convert';
import '../data/news_repository.dart';
import 'news_event.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;
  int page = 1;
  List<Articles>? loadedArticles = [];

  NewsBloc({required this.newsRepository}) : super(NewsBlocInitial()) {
    on<FetchNewsEvent>(_fetchNewsEvent);
    on<FetchMoreNewsEvent>(_fetchMoreNews);
  }

  Future<void> _fetchNewsEvent(
      FetchNewsEvent event, Emitter<NewsState> emit) async {
    try {
      emit(NewsLoadingState());
      final newsData = await newsRepository.fetchNews(page: page);
      emit(NewsSuccessState(newsData: newsData));
    } catch (e) {
      emit(NewsFailureState());
    }
  }

  Future<void> _fetchMoreNews(
      FetchMoreNewsEvent event, Emitter<NewsState> emit) async {
    try {
      final nextPage = (loadedArticles!.length ~/ 20) + 1;
      final newsData = await newsRepository.fetchNews(page: nextPage);
      loadedArticles!.addAll(newsData.articles!);
      emit(NewsSuccessState(newsData: ArticleModel(articles: loadedArticles)));
      page++;
    } catch (e) {
      emit(NewsFailureState());
    }
  }
}
