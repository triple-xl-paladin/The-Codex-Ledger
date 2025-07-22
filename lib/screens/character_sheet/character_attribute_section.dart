// character_attribute_section.dart
import 'package:flutter/material.dart';
import 'package:daggerheart/models/character.dart';

class AttributeSection extends StatefulWidget {
  final Map<Attribute, int> attributes;
  final ValueChanged<Map<Attribute, int>> onAttributesUpdated;

  const AttributeSection({
    super.key,
    required this.attributes,
    required this.onAttributesUpdated,
  });

  @override
  State<AttributeSection> createState() => _AttributeSectionState();
}

class _AttributeSectionState extends State<AttributeSection> {
  void _editAttribute(Attribute attr, int currentValue) async {
    final controller = TextEditingController(text: currentValue.toString());

    final result = await showDialog<int>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            void updateController(int delta) {
              final current = int.tryParse(controller.text) ?? 0;
              final updated = (current + delta).clamp(0, 99);
              controller.text = updated.toString();
              setState(() {});
            }

            return AlertDialog(
              title: Text('Edit ${attr.name.toUpperCase()}'),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: (int.tryParse(controller.text) ?? 0) > 0
                        ? () => updateController(-1)
                        : null,
                  ),
                  SizedBox(
                    width: 60,
                    child: TextField(
                      controller: controller,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Value',
                        isDense: true,
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () => updateController(1),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.pop(context),
                ),
                ElevatedButton(
                  child: const Text('Save'),
                  onPressed: () {
                    final value = int.tryParse(controller.text.trim());
                    if (value != null) {
                      Navigator.pop(context, value);
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );

    if (result != null) {
      final newAttributes = Map<Attribute, int>.from(widget.attributes);
      newAttributes[attr] = result;
      widget.onAttributesUpdated(newAttributes);
    }
  }

  @override
  Widget build(BuildContext context) {
    final attributes = widget.attributes;
    return Table(
      border: TableBorder.all(color: Colors.grey),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.grey[800]),
          children: attributes.keys.map((attr) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                attr.name.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          }).toList(),
        ),
        TableRow(
          children: attributes.entries.map((entry) {
            return InkWell(
              onTap: () => _editAttribute(entry.key, entry.value),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  entry.value.toString(),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
