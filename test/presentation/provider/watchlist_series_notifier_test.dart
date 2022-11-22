import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_watchlist_series.dart';
import 'package:ditonton/presentation/provider/watchlist_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_series_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistSeries])
void main() {
  late WatchlistSeriesNotifier provider;
  late MockGetWatchlistSeries mockGetWatchlistSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistSeries = MockGetWatchlistSeries();
    provider = WatchlistSeriesNotifier(
      getWatchlistSeries: mockGetWatchlistSeries,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetWatchlistSeries.execute())
        .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
    // act
    await provider.fetchWatchlistSeries();
    // assert
    expect(provider.watchlistState, RequestState.Error);
    expect(provider.message, "Can't get data");
    expect(listenerCallCount, 2);
  });
}
