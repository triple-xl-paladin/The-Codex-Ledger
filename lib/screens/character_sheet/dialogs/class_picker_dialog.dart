import 'package:flutter/material.dart';
import 'package:daggerheart/models/character_class.dart';
import 'package:markdown_widget/markdown_widget.dart';

class ClassPickerDialog extends StatelessWidget {
  final List<CharacterClass> availableClasses;
  final CharacterClass? selectedClass;

  const ClassPickerDialog({
    super.key,
    required this.availableClasses,
    this.selectedClass,
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
                'Select Class',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: availableClasses.length,
                itemBuilder: (context, index) {
                  final cClass = availableClasses[index];
                  final isSelected = cClass.name == selectedClass?.name;

                  return InkWell(
                    onTap: () => Navigator.pop(context, cClass),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  cClass.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                              ),
                              const SizedBox(height: 8),
                              IgnorePointer(
                                child: MarkdownWidget(
                                  data: cClass.description,
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
