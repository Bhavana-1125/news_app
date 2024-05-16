import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news_state.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/models/article_data_model.dart';

import '../data/news_repository.dart';
import 'news_event.dart';



class NewsBloc extends Bloc<NewsEvent, NewsState>{
  final NewsRepository newsRepository;
  List<Articles>? loadedArticles = [];

  NewsBloc({required this.newsRepository}) : super(NewsBlocInitial()){
     on<FetchNewsEvent>(fetchNewsEvent);
     on<FetchMoreNewsEvent>(_fetchMoreNews);
  }

Future<void> fetchNewsEvent(FetchNewsEvent event, Emitter<NewsState>emit) async{
    try {
      emit(NewsLoadingState());
      final newsData = await newsRepository.fetchNews(page: 1);
      emit(NewsSuccessState(newsData: newsData));
    } catch (e) {
      emit(NewsFailureState());
    }
}

  Future<void> _fetchMoreNews(FetchMoreNewsEvent event, Emitter<NewsState> emit) async {
    try {
      final nextPage = (loadedArticles!.length ~/ 20) + 1;
      final newsData = await newsRepository.fetchNews(page: nextPage);
      loadedArticles!.addAll(newsData.articles!);
      emit(NewsSuccessState(newsData: ArticleModel(articles: loadedArticles)));
    } catch (e) {
      emit(NewsFailureState());
    }
  }
}

