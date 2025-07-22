import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_data_provider.dart';
import 'package:markdown_widget/markdown_widget.dart';
import '../../theme/markdown_theme.dart'; // adjust path as needed
import 'package:daggerheart/models/items.dart';

class ItemsListScreen extends StatefulWidget {
  const ItemsListScreen({
    super.key,
  });

  @override
  State <ItemsListScreen> createState() => _ItemsListScreenState();
}

class _ItemsListScreenState extends State<ItemsListScreen> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
  }

  List<ItemsModel> _filteredItems(List<ItemsModel> itemsList) {
    return itemsList.where((item) {
      final matchesSearch = _searchQuery.isEmpty ||
          item.itemName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.itemFeature!.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesSearch;
    }).toList();
  }

  Widget _buildCardTile(ItemsModel item) {
    final theme = Theme.of(context);
    
    return ListTile(
      leading: (item.itemImage != null)
          ? SizedBox(
        width: 50,
        height: 50,
        child: Image.asset(
          'assets/images/${item.itemImage}',
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) =>
              Icon(Icons.image_not_supported),
        ),
      )
          : Icon(Icons.image_not_supported, size: 50),
      title: Text(item.itemName),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MarkdownWidget(
            data: item.itemFeature ?? 'No description of item',
            config: buildMarkdownConfigFromTheme(theme),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
          ),
        ],
      ),
      isThreeLine: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppDataProvider>(
        builder: (context, appData, _) {
          if (appData.isLoading) {
            return Scaffold(
              appBar: AppBar(title: Text("Items and Consumables")),
              body: Center(child: CircularProgressIndicator(),),
            );
          } // if

          final List<ItemsModel> filteredItems = _filteredItems(appData.items);

          return Scaffold(
            appBar: AppBar(
              title: Text('Items and Consumables'),
            ),
            body: ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final card = filteredItems[index];
                  return _buildCardTile(card);
                } // itemBuilder
            ),
          );
        } //builder
    );
  }
}
