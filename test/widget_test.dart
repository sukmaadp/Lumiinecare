import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('LoginPage UI Test setelah Splash', (WidgetTester tester) async {
    // Build MyApp (mulai dari splash)
    await tester.pumpWidget(const MyApp());

    // Tunggu splash screen selesai (misalnya 3 detik, lebih aman)
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // ✅ Sekarang sudah di LoginPage

    expect(find.byKey(const Key("emailField")), findsOneWidget);
    expect(find.byKey(const Key("passwordField")), findsOneWidget);
    expect(find.byKey(const Key("loginButton")), findsOneWidget);

    // Input ke email
    await tester.enterText(
      find.byKey(const Key("emailField")),
      "test@email.com",
    );
    expect(find.text("test@email.com"), findsOneWidget);

    // Input ke password
    await tester.enterText(find.byKey(const Key("passwordField")), "123456");
    expect(find.text("123456"), findsOneWidget);

    // Tap tombol login
    await tester.tap(find.byKey(const Key("loginButton")));
    await tester.pump(const Duration(milliseconds: 300));

    // SnackBar muncul
    expect(find.text("Login button pressed"), findsOneWidget);
  });
}
