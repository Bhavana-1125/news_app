import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class FetchNewsEvent extends NewsEvent {
  final int page;

  const FetchNewsEvent({required this.page});

  @override
  List<Object> get props => [page];
}

class FetchMoreNewsEvent extends NewsEvent {
  const FetchMoreNewsEvent();

  @override
  List<Object> get props => [];
}

