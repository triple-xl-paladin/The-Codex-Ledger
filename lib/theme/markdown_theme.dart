import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';

MarkdownConfig buildMarkdownConfigFromTheme(ThemeData theme) {
  final textColor = theme.textTheme.bodyMedium?.color ?? Colors.white70;
  final headerColor = theme.colorScheme.primary;
  final blockquoteColor = theme.colorScheme.secondary;

  return MarkdownConfig(configs: [
    PConfig(
      textStyle: TextStyle(
        color: textColor,
        fontSize: 14,
      ),
    ),
    H1Config(
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: headerColor,
      ),
    ),
    H2Config(
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: headerColor.withValues(alpha: 0.85),
      ),
    ),
    H3Config(
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: headerColor.withValues(alpha: 0.7),
      ),
    ),
    BlockquoteConfig(
      sideColor: blockquoteColor,
      textColor: blockquoteColor.withValues(alpha: 0.8),
      sideWith: 4.0,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 8),
    ),
    // You can add ListConfig, CodeConfig, etc., as needed
  ]);
}

/*
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
 */