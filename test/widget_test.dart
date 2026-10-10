import 'dart:ui' show Size;

import 'package:flutter_test/flutter_test.dart';

import 'package:portfolio/main.dart';

void main() {
  testWidgets('portfolio home page renders its primary content', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1920, 1400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());

    expect(find.text('// Joshua Nelson'), findsOneWidget);
    expect(find.text('View Apps'), findsOneWidget);
    expect(find.text("Let's build something useful."), findsOneWidget);
  });

  testWidgets('portfolio lays out every section at iPhone width', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());

    expect(find.text('// Joshua Nelson'), findsOneWidget);
    expect(find.text('A bit about me'), findsOneWidget);
    expect(find.text('Technologies I work with'), findsOneWidget);
    expect(find.text("Projects I've worked on"), findsOneWidget);
    expect(find.text("Let's build something useful."), findsOneWidget);
  });
}
