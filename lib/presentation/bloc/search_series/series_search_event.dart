part of 'series_search_bloc.dart';

abstract class SeriesSearchEvent extends Equatable {
  const SeriesSearchEvent();

  @override
  List<Object> get props => [];
}

class OnSeriesQueryChanged extends SeriesSearchEvent {
  final String query;
  const OnSeriesQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}
