part of 'series_bloc.dart';

abstract class SeriesState extends Equatable {
  const SeriesState();

  @override
  List<Object> get props => [];
}

class SeriesEmpty extends SeriesState {}

class SeriesLoading extends SeriesState {}

class SeriesHasData extends SeriesState {
  final List<Series> series;

  const SeriesHasData(this.series);
  @override
  List<Object> get props => [series];
}

class SeriesHasError extends SeriesState {
  final String message;

  const SeriesHasError(this.message);
  @override
  List<Object> get props => [message];
}

class SeriesDetailHasData extends SeriesState {
  final SeriesDetail series;

  const SeriesDetailHasData(this.series);
  @override
  List<Object> get props => [series];
}

class WatchlistSeriesHasData extends SeriesState {
  final List<Series> watchlistSeries;

  const WatchlistSeriesHasData(this.watchlistSeries);

  @override
  List<Object> get props => [watchlistSeries];
}

class WatchlistSeriesMessage extends SeriesState {
  final String message;
  const WatchlistSeriesMessage(this.message);
}

class LoadSeriesWatchlistData extends SeriesState {
  final bool status;
  const LoadSeriesWatchlistData(this.status);

  @override
  List<Object> get props => [status];
}
