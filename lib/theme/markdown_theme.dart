import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';

final darkFantasyMarkdownConfig = MarkdownConfig(configs: [
  PConfig(
    textStyle: const TextStyle(
      color: Colors.white70,
      fontSize: 14,
    ),
  ),
  H1Config(
    style: const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.deepPurpleAccent,
    ),
  ),
  H2Config(
    style: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.deepPurple,
    ),
  ),
  H3Config(
    style: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.purple,
    ),
  ),
  BlockquoteConfig(
    sideColor: Colors.deepPurple,  // The color of the side border
    textColor: Colors.deepPurple.shade700,  // Text color inside blockquote
    sideWith: 4.0, // thickness of side border
    padding: EdgeInsets.all(12),
    margin: EdgeInsets.symmetric(vertical: 8),
  ),
]);
