import 'package:daggerheart/extensions/iterable_extensions.dart';
import 'package:daggerheart/screens/card_screens/armour_list_screen.dart';
import 'package:daggerheart/screens/card_screens/items_list_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:url_launcher/url_launcher.dart';
//import 'dart:async';
import 'package:provider/provider.dart';

import 'package:daggerheart/screens/character_sheet/character_class_feature_section.dart';
import 'package:daggerheart/screens/character_sheet/character_class_section.dart';
import 'package:daggerheart/screens/character_sheet/dialogs/domain_card_selection_dialog.dart';

import 'package:daggerheart/services/database_helper.dart';
//import 'package:daggerheart/services/card_service.dart';
//import 'package:daggerheart/services/class_service.dart';

import 'package:daggerheart/models/character.dart';
import 'package:daggerheart/models/domain_card.dart';
//import 'package:daggerheart/models/character_class.dart';

import 'package:daggerheart/providers/app_data_provider.dart';

import '../utils/debug_utils.dart';

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