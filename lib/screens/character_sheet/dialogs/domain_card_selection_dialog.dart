import 'package:flutter/material.dart';
import 'package:daggerheart/models/domain_card.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:daggerheart/theme/markdown_theme.dart';

class DomainCardSelectionDialog extends StatefulWidget {
  final List<DomainCardModel> availableCards;
  final List<DomainCardModel> initiallySelected;

  const DomainCardSelectionDialog({
    super.key,
    required this.availableCards,
    required this.initiallySelected,
  });

  @override
  State<DomainCardSelectionDialog> createState() => _DomainCardSelectionDialogState();
}

class _DomainCardSelectionDialogState extends State<DomainCardSelectionDialog> {
  final Set<DomainCardModel> _selectedCards = {};

  @override
  void initState() {
    super.initState();
    _selectedCards.addAll(widget.initiallySelected);
  }

  void _toggleCard(DomainCardModel card) {
    setState(() {
      if (_selectedCards.contains(card)) {
        _selectedCards.remove(card);
      } else {
        _selectedCards.add(card);
      }
    });
  }

  bool _isCardSelected(DomainCardModel card) => _selectedCards.contains(card);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Dialog(
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Select Cards (${_selectedCards.length})'),
            actions: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          if (widget.availableCards.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('No cards available for selection.'),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: widget.availableCards.length,
                itemBuilder: (context, index) {
                  final card = widget.availableCards[index];
                  //final isSelected = _selectedCards.contains(card);
                  //final isSelected = _isCardSelected(card);

                  return InkWell(
                    onTap: () => _toggleCard(card),
                    child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      value: _isCardSelected(card),
                      onChanged: (val) {
                        if (val != _isCardSelected(card)) {
                          _toggleCard(card);
                        }
                      },
                      title: Text(card.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MarkdownWidget(
                            data: card.feature,
                            config: buildMarkdownConfigFromTheme(theme),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '[${card.domain} | ${card.type} | Level ${card.level}]',
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
                      Navigator.of(context).pop(_selectedCards.toList());
                    },
                  ),
                ),
                const SizedBox(width: 12),
                TextButton(
                  onPressed: () => setState(() => _selectedCards.clear()),
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
