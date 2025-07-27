import 'package:daggerheart/models/weapon.dart';
import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:daggerheart/theme/markdown_theme.dart';

import '../../../utils/debug_utils.dart';

class WeaponSelectionDialog extends StatefulWidget {
  final List<WeaponModel> availableWeapons;
  final List<WeaponModel> initiallySelected;

  const WeaponSelectionDialog({
    super.key,
    required this.availableWeapons,
    required this.initiallySelected,
  });

  @override
  State<WeaponSelectionDialog> createState() => _WeaponSelectionDialogState();
}

class _WeaponSelectionDialogState extends State<WeaponSelectionDialog> {
  final Set<WeaponModel> _selectedWeapons = {};

  @override
  void initState() {
    super.initState();
    _selectedWeapons.addAll(widget.initiallySelected);
    debugLog('WeaponSelectionDialogState: initiallySelected count ${widget.initiallySelected.length}');
  }

  void _toggleCard(WeaponModel weapon) {
    setState(() {
      if (_selectedWeapons.contains(weapon)) {
        _selectedWeapons.remove(weapon);
      } else {
        _selectedWeapons.add(weapon);
      }
    });
  }

  bool _isCardSelected(WeaponModel weapon) => _selectedWeapons.contains(weapon);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Select Weapons (${_selectedWeapons.length})'),
            actions: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          if (widget.availableWeapons.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('No weapons available for selection.'),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: widget.availableWeapons.length,
                itemBuilder: (context, index) {
                  final weapon = widget.availableWeapons[index];

                  return InkWell(
                    onTap: () => _toggleCard(weapon),
                    child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      value: _isCardSelected(weapon),
                      onChanged: (val) {
                        if (val != _isCardSelected(weapon)) {
                          _toggleCard(weapon);
                        }
                      },
                      title: Text(weapon.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MarkdownWidget(
                            data: weapon.feature,
                            config: darkFantasyMarkdownConfig,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Type ${weapon.type} | Level ${weapon.tier}]',
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
                      Navigator.of(context).pop(_selectedWeapons.toList());
                    },
                  ),
                ),
                const SizedBox(width: 12),
                TextButton(
                  onPressed: () => setState(() => _selectedWeapons.clear()),
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
