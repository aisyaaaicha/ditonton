import 'package:ditonton/domain/usecases/get_watchlist_status_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListStatusSeries usecase;
  late MockSeriesRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockSeriesRepository();
    usecase = GetWatchListStatusSeries(mockMovieRepository);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockMovieRepository.isAddedToWatchlistSeries(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
