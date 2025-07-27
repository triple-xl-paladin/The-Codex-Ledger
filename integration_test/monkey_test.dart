/*
 * This file is part of The Codex Ledger.
 *
 * The Codex Ledger is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * The Codex Ledger is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with The Codex Ledger.  If not, see <https://www.gnu.org/licenses/>.
 */

import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:daggerheart/main.dart' as app; // adjust import as needed

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Random tap monkey test', (WidgetTester tester) async {
    List<String> args = ['--debug'];
    app.main(args);
    await tester.pumpAndSettle();

    final random = Random();

    // Perform 100 random taps on widgets found in the widget tree
    for (int i = 0; i < 100; i++) {
      // Find all tappable widgets
      final tappables = find.byWidgetPredicate((widget) {
        return widget is GestureDetector ||
            widget is InkWell ||
            widget is ElevatedButton ||
            widget is TextButton ||
            widget is IconButton;
      });

      final tappableElements = tappables.evaluate().toList();

      if (tappableElements.isEmpty) {
        print('No tappable widgets found!');
        break;
      }

      // Pick a random tappable widget
      final randomIndex = random.nextInt(tappableElements.length);
      final target = tappableElements[randomIndex];

      print('Tapping widget: $target');

      // Tap it
      await tester.tap(find.byElementPredicate((el) => el == target));
      await tester.pumpAndSettle(Duration(milliseconds: 300));
    }
  });
}
