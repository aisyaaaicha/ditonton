import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/search_series.dart';
import 'package:ditonton/presentation/provider/series_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'series_search_notifier_test.mocks.dart';

@GenerateMocks([SearchSeries])
void main() {
  late SeriesSearchNotifier provider;
  late MockSearchSeries mockSearchSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchSeries = MockSearchSeries();
    provider = SeriesSearchNotifier(searchSeries: mockSearchSeries)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tQuery = 'all american';

  group('search movies', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchSeries.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchSeriesSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
