part of 'series_bloc.dart';

abstract class SeriesEvent extends Equatable {
  const SeriesEvent();

  @override
  List<Object> get props => [];
}

class FetchNowPlayingSeries extends SeriesEvent {}

class FetchPopularSeries extends SeriesEvent {}

class FetchTopRatedSeries extends SeriesEvent {}

class FetchSeriesDetail extends SeriesEvent {
  final int id;
  const FetchSeriesDetail(this.id);

  @override
  List<Object> get props => [id];
}

class FetchSeriesRecommendations extends SeriesEvent {
  final int id;
  const FetchSeriesRecommendations(this.id);

  @override
  List<Object> get props => [id];
}

class FetchWatchlistSeries extends SeriesEvent {}

class AddWatchlistSeries extends SeriesEvent {
  final SeriesDetail series;

  const AddWatchlistSeries(this.series);
  @override
  List<Object> get props => [series];
}

class RemoveWatchlistSerieses extends SeriesEvent {
  final SeriesDetail series;

  const RemoveWatchlistSerieses(this.series);
  @override
  List<Object> get props => [series];
}

class LoadWatchlistSeriesStatus extends SeriesEvent {
  final int id;

  const LoadWatchlistSeriesStatus(this.id);
  @override
  List<Object> get props => [id];
}
