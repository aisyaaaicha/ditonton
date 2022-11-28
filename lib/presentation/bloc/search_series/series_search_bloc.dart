import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/search_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
part 'series_search_event.dart';
part 'series_search_state.dart';

class SeriesSearchBloc extends Bloc<SeriesSearchEvent, SeriesSearchState> {
  final SearchSeries _searchSeries;

  SeriesSearchBloc(this._searchSeries) : super(SeriesSearchEmpty()) {
    on<OnSeriesQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SeriesSearchLoading());
      final result = await _searchSeries.execute(query);

      result.fold(
        (failure) {
          emit(SeriesSearchError(failure.message));
        },
        (data) {
          emit(SeriesSearchHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
