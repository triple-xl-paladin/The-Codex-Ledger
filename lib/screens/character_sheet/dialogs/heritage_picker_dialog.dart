import 'package:flutter/material.dart';
import 'package:daggerheart/models/character_heritage.dart';
import 'package:markdown_widget/markdown_widget.dart';

class HeritagePickerDialog extends StatelessWidget {
  final List<CharacterHeritage> availableHeritage;
  final CharacterHeritage? selectedHeritage;

  const HeritagePickerDialog({
    super.key,
    required this.availableHeritage,
    this.selectedHeritage,
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
              'Select Heritage',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: availableHeritage.length,
                itemBuilder: (context, index) {
                  final cHeritage = availableHeritage[index];
                  final isSelected = cHeritage.name == selectedHeritage?.name;

                  return InkWell(
                    onTap: () => Navigator.pop(context, cHeritage),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cHeritage.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              IgnorePointer(
                                child: MarkdownWidget(
                                  data: cHeritage.description,
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
