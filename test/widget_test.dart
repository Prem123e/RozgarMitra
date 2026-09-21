import 'package:flutter_test/flutter_test.dart';
import 'package:rozgar_mitra/main.dart';

void main() {
  testWidgets('RozgarMitra app starts successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const RozgarMitraApp());

    expect(find.text('RozgarMitra'), findsOneWidget);
    expect(find.text('Choose your language'), findsOneWidget);
  });
}