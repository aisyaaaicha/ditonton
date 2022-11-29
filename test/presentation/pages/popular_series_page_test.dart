import 'package:ditonton/presentation/bloc/series/series_bloc.dart';
import 'package:ditonton/presentation/pages/popular_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/series_dummy_objects.dart';
import '../../helpers/test_helper.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late PopularSeriesBloc popularSeriesBloc;

  setUp(() {
    popularSeriesBloc = PopularSeriesBlocHelper();
    registerFallbackValue(PopularSeriesStateHelper());
    registerFallbackValue(PopularSeriesEventHelper());
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<PopularSeriesBloc>(
      create: (_) => popularSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => popularSeriesBloc.state).thenReturn(SeriesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(PopularSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should dispay ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => popularSeriesBloc.state).thenReturn(SeriesLoading());
    when(() => popularSeriesBloc.state)
        .thenReturn(SeriesHasData(testSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(PopularSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });
}
