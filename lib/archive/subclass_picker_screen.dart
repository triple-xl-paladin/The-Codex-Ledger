/*
import 'package:daggerheart/models/character_subclass.dart';
import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import '../models/character_class.dart';

class SubclassPickerScreen extends StatelessWidget {
  final CharacterClass selectedClass;
  final List<CharacterSubclass> subclassDetails;  // Your loaded subclass cards

  const SubclassPickerScreen({
    required this.selectedClass,
    required this.subclassDetails,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subclasses = selectedClass.availableSubClasses;

    // Filter the subclassDetails for only those matching availableSubClasses
    final matchingDetails = subclassDetails.where((card) =>
        subclasses.any((s) => s.toLowerCase().trim() == card.name.toLowerCase().trim())
    ).toList();

    return Scaffold(
      appBar: AppBar(title: Text('Select Subclass')),
      body: ListView.builder(
        itemCount: matchingDetails.length,
        itemBuilder: (context, index) {
          final detail = matchingDetails[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                //print('Subclass selected: ${detail.name}');
                //ScaffoldMessenger.of(context).showSnackBar(
                //  SnackBar(content: Text('Tapped: ${detail.name}')),
                //);
                Navigator.pop(context, detail.name);  // Return the subclass name
              },
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      detail.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                  ),
                  IgnorePointer(
                    child:
                    MarkdownWidget(
                      data: detail.description,
                      shrinkWrap: true,
                    ),
                  ),
                ],
              ),
            ),
            ),
          );
        },
      ),
    );
  }
}


 */