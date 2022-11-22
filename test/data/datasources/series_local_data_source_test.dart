import 'package:ditonton/data/datasources/series_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/series_dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SeriesLocalDataSourceImpl dataSource;
  late MockSeriesDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockSeriesDatabaseHelper();
    dataSource = SeriesLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('Get Series Detail By Id', () {
    final tId = 1;

    test('should return Series Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getSeriesById(tId))
          .thenAnswer((_) async => testSeriesMap);
      // act
      final result = await dataSource.getSeriesById(tId);
      // assert
      expect(result, testSeriesTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getSeriesById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getSeriesById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist series', () {
    test('should return list of MovieTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistSeries())
          .thenAnswer((_) async => [testSeriesMap]);
      // act
      final result = await dataSource.getWatchlistSeries();
      // assert
      expect(result, [testSeriesTable]);
    });
  });
}
