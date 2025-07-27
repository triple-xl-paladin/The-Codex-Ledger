//import 'package:flutter/foundation.dart';
//import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:markdown_widget/markdown_widget.dart';
import 'package:daggerheart/theme/markdown_theme.dart'; // adjust path as needed

import 'package:daggerheart/extensions/iterable_extensions.dart';
//import 'package:daggerheart/utils/debug_utils.dart';

import 'package:daggerheart/models/character.dart';
import 'package:daggerheart/models/character_class.dart';

//import 'package:daggerheart/services/class_service.dart';

import 'package:daggerheart/providers/app_data_provider.dart';

/// Section of the character sheet displaying the hope and class features.
class CharacterClassFeatureSection extends StatelessWidget {
  final Character character;
  //final Function(Character) onCharacterUpdated;

  const CharacterClassFeatureSection({
    super.key,
    required this.character,
    //required this.onCharacterUpdated,
  });

  Widget buildHopeFeature(BuildContext context, CharacterClass cls) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
            Text('Hope Feature', style: Theme.of(context).textTheme.titleLarge,),
            MarkdownWidget(
              data: cls.hopeFeature, //?? 'No hope feature',
              config: buildMarkdownConfigFromTheme(theme),
              shrinkWrap: true,
            )
      ]
    );
  }

  Widget buildClassFeatures(BuildContext context, CharacterClass cls) {
    final theme = Theme.of(context);
    
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Class Features', style: Theme.of(context).textTheme.titleLarge,),
          SizedBox(height: 8,),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: cls.classFeatures.map((feature) {
              return Card(
                color: Theme.of(context).cardColor,
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MarkdownWidget(
                    data: feature, // ?? 'No class feature',
                    config: buildMarkdownConfigFromTheme(theme),
                    shrinkWrap: true,
                  ),
                ),
              );
            }).toList(),
          ),
        ]
    );
  }

  /// Main build for Character Class section
  @override
  Widget build(BuildContext context) {
    //debugLog('Rebuilding feature section for class: ${widget.character.characterClass}');
    final appData = Provider.of<AppDataProvider>(context);

    if (appData.isLoading) {
      return const Text('Class data loading...');
    }

    if (appData.error != null) {
      return Text('Error loading data: ${appData.error}');
    }

    final classes = appData.classes;
    final cls = classes.firstWhereOrNull(
          (c) => c.name == character.characterClass,
    );

    if (cls == null) {
      return const Text('Class missing');
    }

    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
              buildHopeFeature(context, cls), // Hope feature
              SizedBox(width: 8,),
              buildClassFeatures(context, cls), // Class feature
        ],
      );
  }
}