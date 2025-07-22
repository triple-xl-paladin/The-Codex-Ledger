import 'package:flutter/material.dart';
import 'package:daggerheart/models/character_class.dart';
import 'package:daggerheart/models/character_subclass.dart';
import 'package:markdown_widget/markdown_widget.dart';

class SubclassPickerDialog extends StatelessWidget {
  final CharacterClass selectedClass;
  final List<CharacterSubclass> subclassDetails;

  const SubclassPickerDialog({
    required this.selectedClass,
    required this.subclassDetails,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final subclasses = selectedClass.availableSubClasses;

    final matchingDetails = subclassDetails.where((card) =>
        subclasses.any((s) => s.toLowerCase().trim() == card.name.toLowerCase().trim())
    ).toList();

    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Select Subclass',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: matchingDetails.length,
              itemBuilder: (context, index) {
                final detail = matchingDetails[index];
                return InkWell(
                  onTap: () => Navigator.pop(context, detail.name),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              detail.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            IgnorePointer(
                              child: MarkdownWidget(
                                data: detail.description,
                                shrinkWrap: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
