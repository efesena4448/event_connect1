import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:event_connect/main.dart';
import 'package:event_connect/database.dart';

// Mock sınıfı, AppDatabase yerine geçecek şekilde tanımlanır
class MockAppDatabase extends Mock implements AppDatabase {}

void main() {
  testWidgets('MyApp has a title', (WidgetTester tester) async {
    // Mock veritabanı oluşturulur
    final mockDatabase = MockAppDatabase();

    // MyApp widget'ı mock veritabanı ile çalıştırılır
    await tester.pumpWidget(MyApp(database: mockDatabase));

    // Başlık metni bulunur ve doğrulanır
    final titleFinder = find.text('Event Connect');

    expect(titleFinder, findsOneWidget);
  });
}
