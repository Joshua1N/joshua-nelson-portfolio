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
}
