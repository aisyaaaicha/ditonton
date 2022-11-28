import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/entities/series_detail.dart';
import 'package:ditonton/domain/usecases/get_series_detail.dart';
import 'package:ditonton/domain/usecases/get_now_playing_series.dart';
import 'package:ditonton/domain/usecases/get_popular_series.dart';
import 'package:ditonton/domain/usecases/get_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_top_rated_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_series.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'series_event.dart';
part 'series_state.dart';

class NowPlayingSeriesBloc extends Bloc<SeriesEvent, SeriesState> {
  final GetNowPlayingSeries _getNowPlayingSeries;

  NowPlayingSeriesBloc(this._getNowPlayingSeries) : super(SeriesEmpty()) {
    on<FetchNowPlayingSeries>((event, emit) async {
      emit(SeriesLoading());
      final result = await _getNowPlayingSeries.execute();

      result.fold((failure) {
        emit(SeriesHasError(failure.message));
      }, (seriesData) {
        emit(SeriesHasData(seriesData));
      });
    });
  }
}

class PopularSeriesBloc extends Bloc<SeriesEvent, SeriesState> {
  final GetPopularSeries _getPopularSeries;

  PopularSeriesBloc(this._getPopularSeries) : super(SeriesEmpty()) {
    on<FetchPopularSeries>((event, emit) async {
      emit(SeriesLoading());
      final result = await _getPopularSeries.execute();

      result.fold((failure) {
        emit(SeriesHasError(failure.message));
      }, (seriesData) {
        emit(SeriesHasData(seriesData));
      });
    });
  }
}

class TopRatedSeriesBloc extends Bloc<SeriesEvent, SeriesState> {
  final GetTopRatedSeries _getTopRatedSeries;

  TopRatedSeriesBloc(this._getTopRatedSeries) : super(SeriesEmpty()) {
    on<FetchTopRatedSeries>((event, emit) async {
      emit(SeriesLoading());
      final result = await _getTopRatedSeries.execute();

      result.fold((failure) {
        emit(SeriesHasError(failure.message));
      }, (seriesData) {
        emit(SeriesHasData(seriesData));
      });
    });
  }
}

class SeriesDetailBloc extends Bloc<SeriesEvent, SeriesState> {
  final GetSeriesDetail _getSeriesDetail;

  SeriesDetailBloc(this._getSeriesDetail) : super(SeriesEmpty()) {
    on<FetchSeriesDetail>((event, emit) async {
      final id = event.id;
      emit(SeriesLoading());
      final result = await _getSeriesDetail.execute(id);

      result.fold(
        (failure) {
          emit(SeriesHasError(failure.message));
        },
        (series) {
          emit(SeriesDetailHasData(series));
        },
      );
    });
  }
}

class RecommendationsSeriesBloc extends Bloc<SeriesEvent, SeriesState> {
  final GetSeriesRecommendations _getSeriesRecommendations;

  RecommendationsSeriesBloc(this._getSeriesRecommendations)
      : super(SeriesEmpty()) {
    on<FetchSeriesRecommendations>((event, emit) async {
      final int id = event.id;

      emit(SeriesLoading());
      final result = await _getSeriesRecommendations.execute(id);

      result.fold((failure) {
        emit(SeriesHasError(failure.message));
      }, (seriesData) {
        emit(SeriesHasData(seriesData));
      });
    });
  }
}

class WatchlistSeriesBloc extends Bloc<SeriesEvent, SeriesState> {
  final GetWatchlistSeries getWatchlistSeries;
  final GetWatchListStatusSeries getWatchListStatusSeries;
  final SaveWatchlistSeries saveWatchlistSeries;
  final RemoveWatchlistSeries removeWatchlistSeries;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  WatchlistSeriesBloc(this.getWatchlistSeries, this.getWatchListStatusSeries,
      this.saveWatchlistSeries, this.removeWatchlistSeries)
      : super(SeriesEmpty()) {
    on<FetchWatchlistSeries>((event, emit) async {
      emit(SeriesLoading());
      final result = await getWatchlistSeries.execute();

      result.fold((failure) {
        emit(SeriesHasError(failure.message));
      }, (seriesData) {
        emit(WatchlistSeriesHasData(seriesData));
      });
    });
    on<AddWatchlistSeries>((event, emit) async {
      final series = event.series;

      emit(SeriesLoading());
      final result = await saveWatchlistSeries.execute(series);

      result.fold((failure) {
        emit(SeriesHasError(failure.message));
      }, (successMessage) {
        emit(WatchlistSeriesMessage(successMessage));
      });
    });
    on<LoadWatchlistSeriesStatus>((event, emit) async {
      final id = event.id;

      emit(SeriesLoading());
      final result = await getWatchListStatusSeries.execute(id);

      emit(LoadSeriesWatchlistData(result));
    });
    on<RemoveWatchlistSerieses>((event, emit) async {
      final series = event.series;

      emit(SeriesLoading());
      final result = await removeWatchlistSeries.execute(series);

      result.fold((failure) {
        emit(SeriesHasError(failure.message));
      }, (successMessage) {
        emit(WatchlistSeriesMessage(successMessage));
      });
    });
  }
}
