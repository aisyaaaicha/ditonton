import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/search_series.dart';
import 'package:ditonton/presentation/bloc/search_series/series_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'searchseries_bloc_test.mocks.dart';

@GenerateMocks([SearchSeries])
void main() {
  late MockSearchSeries mockSearchSeries;
  late SeriesSearchBloc seriesSearchBloc;

  setUp(() {
    mockSearchSeries = MockSearchSeries();
    seriesSearchBloc = SeriesSearchBloc(mockSearchSeries);
  });

  group('Search Series Bloc Test', () {
    final seriesModel = Series(
      genreIds: [35],
      id: 32568,
      name: 'Till Death Us Do Part',
      originalName: "Till Death Us Do Part",
      overview:
          "Following the chronicles of the East End working-class Garnett family, headed by patriarch Alf Garnett, a reactionary working-class man who holds racist and anti-socialist views.",
      popularity: 4.321,
      posterPath: "/5r8enLaWs3SnVoInZYsOLZgboki.jpg",
      voteAverage: 7.275,
      voteCount: 20,
      backdropPath: '/jeP3It0ZPY3SKW3632qwLkkIZv3.jpg',
    );
    final tSeriesList = <Series>[seriesModel];
    const tQuery = 'All American';
    test('initial state should empty', () {
      expect(seriesSearchBloc.state, SeriesSearchEmpty());
    });

    blocTest<SeriesSearchBloc, SeriesSearchState>(
        'should emit [Loading, HasData] when data is gotten',
        build: () {
          when(mockSearchSeries.execute(tQuery))
              .thenAnswer((_) async => Right(tSeriesList));
          return seriesSearchBloc;
        },
        act: (bloc) => bloc.add(OnSeriesQueryChanged(tQuery)),
        wait: const Duration(milliseconds: 500),
        expect: () => [SeriesSearchLoading(), SeriesSearchHasData(tSeriesList)],
        verify: (bloc) {
          verify(mockSearchSeries.execute(tQuery));
        });
  });
}
