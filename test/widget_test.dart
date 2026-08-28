// AgriRent - Widget Test File

import 'package:flutter_test/flutter_test.dart';
import 'package:agri_rent/main.dart';

void main() {
  testWidgets('AgriRent app smoke test', (WidgetTester tester) async {
    // App ko launch kar rahe hain
    await tester.pumpWidget(const AgriRentApp());
  });
}