import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class FetchNewsEvent extends NewsEvent {}

class FetchMoreNewsEvent extends NewsEvent {
  const FetchMoreNewsEvent();

  @override
  List<Object> get props => [];
}
