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

//import 'package:daggerheart/extensions/iterable_extensions.dart';
//import 'package:daggerheart/screens/card_screens/armour_list_screen.dart';
import 'package:daggerheart/screens/card_screens/items_list_screen.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:url_launcher/url_launcher.dart';
//import 'dart:async';
//import 'package:provider/provider.dart';

//import 'package:daggerheart/screens/character_sheet/character_class_feature_section.dart';
//import 'package:daggerheart/screens/character_sheet/character_class_section.dart';
//import 'package:daggerheart/screens/character_sheet/dialogs/domain_card_selection_dialog.dart';

//import 'package:daggerheart/services/database_helper.dart';
//import 'package:daggerheart/services/card_service.dart';
//import 'package:daggerheart/services/class_service.dart';

//import 'package:daggerheart/models/character.dart';
//import 'package:daggerheart/models/domain_card.dart';
//import 'package:daggerheart/models/character_class.dart';

//import 'package:daggerheart/providers/app_data_provider.dart';

//import '../utils/debug_utils.dart';

/// The Character Sheet screen shows the details of the character. The
/// constructor expects a Character object.
class DebugTestScreen extends StatefulWidget {

  /// Constructor expects a Character object
  const DebugTestScreen({
    super.key,
  });

  @override
  State<DebugTestScreen> createState() => _DebugTestScreenState();
}

/// Private class that contains the layout and widgets for the character screen
class _DebugTestScreenState extends State<DebugTestScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Debug Test Screen"),
        ),
        body:
        /*
        SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Placeholder(),
            ], // children
          ),
        ),
        */
        Padding (
          padding: const EdgeInsets.all(16.0),
          child: ItemsListScreen(),
        ),
    );
  } // build
}