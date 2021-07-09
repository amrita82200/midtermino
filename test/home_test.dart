/*import 'package:chat_midterm/NavigationPages/messages.dart';
import 'package:chat_midterm/NavigationPages/lists.dart';
import 'package:chat_midterm/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:chat_midterm/home_page.dart';

Widget createHomeScreen() => ChangeNotifierProvider<MyHomePage>(
      create: (context) => MyHomePage(title: ''),
      child: MaterialApp(
        home: MyHomePage(
          title: '',
        ),
      ),
    );

Future<void> main() async {
  group('Home Page Widget Tests', () {
    testWidgets('Testing Scrolling', (tester) async {
      await tester.pumpWidget(createHomeScreen());
      expect(find.text('Messages'), findsOneWidget);
      await tester.fling(find.byType(Scaffold), Offset(0, -200), 3000);
      await tester.pumpAndSettle();
      expect(find.text('Home'), findsNothing);
    });
  });
}
*/