import 'package:ditonton/presentation/bloc/series/series_bloc.dart';
import 'package:ditonton/presentation/pages/top_rated_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/series_dummy_objects.dart';
import '../../helpers/test_helper.dart';

void main() {
  late TopRatedSeriesBlocHelper topRatedSeriesBlocHelper;

  setUp(() {
    topRatedSeriesBlocHelper = TopRatedSeriesBlocHelper();
    registerFallbackValue(TopRatedSeriesBlocHelper());
    registerFallbackValue(TopRatedSeriesStateHelper());
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedSeriesBloc>(
      create: (_) => topRatedSeriesBlocHelper,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progtess bar when loading',
      (WidgetTester tester) async {
    when(() => topRatedSeriesBlocHelper.state).thenReturn(SeriesLoading());
    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(TopRatedSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => topRatedSeriesBlocHelper.state)
        .thenAnswer((invocation) => SeriesLoading());
    when(() => topRatedSeriesBlocHelper.state)
        .thenReturn(SeriesHasData(testSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(TopRatedSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => topRatedSeriesBlocHelper.state)
        .thenReturn(SeriesHasError('error'));
    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(TopRatedSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
