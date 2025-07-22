import 'package:flutter/material.dart';
import 'package:daggerheart/models/character_ancestry.dart';
import 'package:markdown_widget/markdown_widget.dart';

class AncestryPickerDialog extends StatelessWidget {
  final List<CharacterAncestry> availableAncestry;
  final CharacterAncestry? selectedAncestry;

  const AncestryPickerDialog({
    super.key,
    required this.availableAncestry,
    this.selectedAncestry,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Select Ancestry',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: availableAncestry.length,
                itemBuilder: (context, index) {
                  final cAncestry = availableAncestry[index];
                  final isSelected = cAncestry.name == selectedAncestry?.name;

                  return InkWell(
                    onTap: () => Navigator.pop(context, cAncestry),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cAncestry.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              IgnorePointer(
                                child: MarkdownWidget(
                                  data: cAncestry.description,
                                  shrinkWrap: true,
                                ),
                              ),
                              if (isSelected) Icon(Icons.check, color: Colors.green),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
