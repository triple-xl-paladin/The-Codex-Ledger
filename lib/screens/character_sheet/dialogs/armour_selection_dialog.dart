import 'package:daggerheart/models/armour.dart';
import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:daggerheart/theme/markdown_theme.dart';
import '../../../utils/debug_utils.dart';

class ArmourSelectionDialog extends StatefulWidget {
  final List<ArmourModel> availableArmour;
  final List<ArmourModel> initiallySelected;

  const ArmourSelectionDialog({
    super.key,
    required this.availableArmour,
    required this.initiallySelected,
  });

  @override
  State<ArmourSelectionDialog> createState() => _ArmourSelectionDialogState();
}

class _ArmourSelectionDialogState extends State<ArmourSelectionDialog> {
  final Set<ArmourModel> _selectedArmours = {};

  @override
  void initState() {
    super.initState();
    _selectedArmours.addAll(widget.initiallySelected);
    debugLog('ArmourSelectionDialogState: availableArmour = ${widget.availableArmour.map((a) => a.armourId).toList()}');
    debugLog('ArmourSelectionDialogState: initiallySelected = ${widget.initiallySelected.map((a) => a.armourId).toList()}');
    debugLog('ArmourSelectionDialogState: initiallySelected count ${widget.initiallySelected.length}');
  }

  void _toggleCard(ArmourModel weapon) {
    setState(() {
      if (_selectedArmours.contains(weapon)) {
        _selectedArmours.remove(weapon);
      } else {
        _selectedArmours.add(weapon);
      }
    });
  }

  bool _isCardSelected(ArmourModel weapon) => _selectedArmours.contains(weapon);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Select Armour (${_selectedArmours.length})'),
            actions: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          if (widget.availableArmour.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('No armour available for selection.'),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: widget.availableArmour.length,
                itemBuilder: (context, index) {
                  final armour = widget.availableArmour[index];

                  return InkWell(
                    onTap: () => _toggleCard(armour),
                    child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      value: _isCardSelected(armour),
                      onChanged: (val) {
                        if (val != _isCardSelected(armour)) {
                          _toggleCard(armour);
                        }
                      },
                      title: Text(armour.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MarkdownWidget(
                            data: armour.feature,
                            config: buildMarkdownConfigFromTheme(theme),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'BaseScore ${armour.baseScore} | Thresholds ${armour.baseThreshold1}/${armour.baseThreshold2} | Level ${armour.tier}]',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[400],
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                      isThreeLine: true,
                    ),
                  );
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.check),
                    label: const Text('Done'),
                    onPressed: () {
                      Navigator.of(context).pop(_selectedArmours.toList());
                    },
                  ),
                ),
                const SizedBox(width: 12),
                TextButton(
                  onPressed: () => setState(() => _selectedArmours.clear()),
                  child: const Text('Clear All'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
