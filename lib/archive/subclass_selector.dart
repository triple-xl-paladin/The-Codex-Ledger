/*
import 'package:daggerheart/extensions/iterable_extensions.dart';
import 'package:flutter/material.dart';
import 'package:daggerheart/models/character_class.dart';
import 'package:daggerheart/models/domain_card.dart';
import 'package:daggerheart/services/card_service.dart';

class SubclassSelector extends StatefulWidget {
  final CharacterClass? selectedClass;
  final String? currentSubclass;
  final Function(String) onSubclassSelected;
//  final List<CardModel> availableSubclassDetails;


  const SubclassSelector({
    Key? key,
    required this.selectedClass,
    required this.currentSubclass,
    required this.onSubclassSelected,
//    required this.availableSubclassDetails,
  }) : super(key: key);

  @override
  _SubclassSelectorState createState() => _SubclassSelectorState();
}

class _SubclassSelectorState extends State<SubclassSelector> {
  List<CardModel> _availableSubclassDetails = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSubclassDetails();
  }

  Future<void> _loadSubclassDetails() async {
    final details = await loadCards(jsonAssetPath: 'assets/subclasses.json');
    if (!mounted) return;
    setState(() {
      _availableSubclassDetails = details;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.selectedClass == null) {
      return Text('Please select a class first');
    }

    if (widget.selectedClass!.availableSubClasses.isEmpty) {
      return Text('No subclasses available for ${widget.selectedClass!.name}');
    }

    return Row(
      children: [
        Text('Subclass: ', style: Theme.of(context).textTheme.titleMedium),
        GestureDetector(
          onTap: () async {
            final selected = await showDialog<String>(
              context: context,
              builder: (context) => SimpleDialog(
                title: Text('Select Subclass'),
                children: widget.selectedClass!.availableSubClasses.map((subName) {
                  final detail = _availableSubclassDetails.firstWhereOrNull(
                        (s) => s.name == subName,
                  );
                  
                  return SimpleDialogOption(
                    onPressed: () => Navigator.pop(context, subName),
                    child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(subName, style: TextStyle(fontWeight: FontWeight.bold),),
                          if(detail != null)
                            Text(detail.feature, style: TextStyle(fontSize: 12),)
                        ]
                      ),    
                    
                  );
                }).toList(),
              ),
            );

            if (selected != null) {
              widget.onSubclassSelected(selected);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade700,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.currentSubclass ?? 'Select Subclass',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  if (widget.currentSubclass != null)
                    Text(
                      _availableSubclassDetails
                          .firstWhereOrNull(
                            (s) => s.name == widget.currentSubclass,
                          )
                          ?.feature ?? '',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                ],
              ),
          ),
        ),
      ],
    );
  }
}

 */