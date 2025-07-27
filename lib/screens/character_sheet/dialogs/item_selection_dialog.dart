import 'package:daggerheart/models/items.dart';
import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:daggerheart/theme/markdown_theme.dart';
import '../../../utils/debug_utils.dart';

class ItemSelectionDialog extends StatefulWidget {
  final List<ItemsModel> availableItems;
  final List<ItemsModel> initiallySelected;

  const ItemSelectionDialog({
    super.key,
    required this.availableItems,
    required this.initiallySelected,
  });

  @override
  State<ItemSelectionDialog> createState() => _ItemSelectionDialogState();
}

class _ItemSelectionDialogState extends State<ItemSelectionDialog> {
  final Set<ItemsModel> _selectedItems = {};

  @override
  void initState() {
    super.initState();
    _selectedItems.addAll(widget.initiallySelected);
    debugLog('ItemSelectionDialogState: availableItems = ${widget.availableItems.map((a) => a.itemId).toList()}');
    debugLog('ItemSelectionDialogState: initiallySelected = ${widget.initiallySelected.map((a) => a.itemId).toList()}');
    debugLog('ItemSelectionDialogState: initiallySelected count ${widget.initiallySelected.length}');
  }

  void _toggleCard(ItemsModel item) {
    setState(() {
      if (_selectedItems.contains(item)) {
        _selectedItems.remove(item);
      } else {
        _selectedItems.add(item);
      }
    });
  }

  bool _isCardSelected(ItemsModel item) => _selectedItems.contains(item);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Dialog(
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Select Items (${_selectedItems.length})'),
            actions: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          if (widget.availableItems.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('No items available for selection.'),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: widget.availableItems.length,
                itemBuilder: (context, index) {
                  final items = widget.availableItems[index];

                  return InkWell(
                    onTap: () => _toggleCard(items),
                    child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      value: _isCardSelected(items),
                      onChanged: (val) {
                        if (val != _isCardSelected(items)) {
                          _toggleCard(items);
                        }
                      },
                      title: Text(items.itemName),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MarkdownWidget(
                            data: items.itemFeature ?? '-',
                            config: buildMarkdownConfigFromTheme(theme),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Type ${items.itemType}',
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
                      Navigator.of(context).pop(_selectedItems.toList());
                    },
                  ),
                ),
                const SizedBox(width: 12),
                TextButton(
                  onPressed: () => setState(() => _selectedItems.clear()),
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
