import 'package:equatable/equatable.dart';
import 'package:news_app/models/article_data_model.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsBlocInitial extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsSuccessState extends NewsState {
  final ArticleModel newsData;

  const NewsSuccessState({required this.newsData});

  @override
  List<Object> get props => [newsData];
}

class NewsFailureState extends NewsState {}
