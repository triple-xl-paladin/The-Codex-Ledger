import 'package:flutter/material.dart';

class FeatureGridTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const FeatureGridTile({required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        margin: EdgeInsets.all(6),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(child: Icon(icon, size: 40, color: Theme.of(context).iconTheme.color),),
                //Icon(icon, size: 40),
                SizedBox(height: 8),
                Flexible(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium,
                    //style: TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
