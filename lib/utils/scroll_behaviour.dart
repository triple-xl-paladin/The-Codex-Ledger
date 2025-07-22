import 'package:flutter/material.dart';

class AlwaysVisibleScrollBehavior extends MaterialScrollBehavior {
  const AlwaysVisibleScrollBehavior();

  @override
  Widget buildScrollbar(
      BuildContext context,
      Widget child,
      ScrollableDetails details,
      ) {
    return Scrollbar(
      controller: details.controller,
      thumbVisibility: true,
      trackVisibility: true,
      child: child,
    );
  }
}
