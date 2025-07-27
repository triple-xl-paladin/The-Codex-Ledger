//import 'dart:ffi';

import 'package:daggerheart/models/armour.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import '../models/domain_card.dart';
import '../../providers/app_data_provider.dart';
//import '../services/card_service.dart';
import 'package:markdown_widget/markdown_widget.dart';
import '../../theme/markdown_theme.dart';
import '../../utils/debug_utils.dart'; // adjust path as needed

class ArmourListScreen extends StatefulWidget {
  
  const ArmourListScreen ({
    super.key,  
  });
  
  @override
  State <ArmourListScreen> createState() => _ArmourListScreenState();
}

class _ArmourListScreenState extends State<ArmourListScreen> {
  //List<ArmourModel> _allArmour = [];
  //List<ArmourModel> _filteredArmour = [];
  final List<int> _tiers = [0, 1,2,3,4,5];
  
  String _searchQuery = '';
  int _selectedTier = 0; // 0 means "no tier filter"
  //bool _loading = true;

  /*
  @override
  void initState() {
    super.initState();

    // Delay to safely access context
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final appData = Provider.of<AppDataProvider>(context, listen: false);
      debugLog('ArmourListScreen: Loaded armour count ${appData.armours.length}');

      if (appData.armours.isEmpty) {
        // Optionally listen for notifyListeners or delay
        Future.delayed(Duration(milliseconds: 100), () {
          final updatedData = Provider.of<AppDataProvider>(context, listen: false);
          setState(() {
            _allArmour = updatedData.armours;
            _filteredArmour = _allArmour;
            //_loading = false;
          });
        });
      } else {
        setState(() {
          _allArmour = appData.armours;
          _filteredArmour = _allArmour;
        });
      } // else
    });
  }

   */

  List<ArmourModel> _filterArmour(List<ArmourModel> armourList) {
    return armourList.where((armourItem) {
      final matchesTier = _selectedTier == 0 || armourItem.tier == _selectedTier;
      final matchesSearch = _searchQuery.isEmpty ||
          armourItem.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          armourItem.feature.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesTier && matchesSearch;
    }).toList();
  }

  /*
  void _applyFilters() {
    setState(() {
      _filteredArmour = _allArmour.where((armourItem) {
        final matchesTier = _selectedTier == 0 || armourItem.tier == _selectedTier;
        final matchesSearch = _searchQuery.isEmpty ||
            armourItem.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            armourItem.feature.toLowerCase().contains(_searchQuery.toLowerCase());

        return matchesTier && matchesSearch;
      }).toList();
    });
  }
   */

  Widget _buildFilterDropdown(String label, int value, List<int> items, ValueChanged<int?> onChanged) {
    return DropdownButton<int>(
      value: value,
      onChanged: onChanged,
      items: items.map((item) {
        return DropdownMenuItem<int>(
          value: item,
          child: Text(item == 0 ? 'All Tiers' : 'Tier $item'),
        );
      }).toList(),
      hint: Text(label),
    );
  }

  Widget _buildArmourTile(ArmourModel armourItem) {
    return ListTile(
      leading: (armourItem.image != null)
          ? SizedBox(
        width: 50,
        height: 50,
        child: Image.asset(
          'assets/images/${armourItem.image}',
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) =>
              Icon(Icons.image_not_supported),
        ),
      )
          : Icon(Icons.image_not_supported, size: 50),
      title: Text(armourItem.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MarkdownWidget(
            data: armourItem.feature,
            config: darkFantasyMarkdownConfig,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
          ),
          const SizedBox(height: 4),
          Text(
            '[${armourItem.baseScore} | ${armourItem.baseThreshold1} | ${armourItem.baseThreshold2} | Tier ${armourItem.tier}]',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey[400],
              fontStyle: FontStyle.italic,
            ),
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
        if(appData.isLoading) {
          return Scaffold(
            appBar: AppBar(title: Text("Armour")),
            body: Center(child: CircularProgressIndicator(),),
          );
        } // if

        //final List<ArmourModel> allArmour = appData.armours;
        final List<ArmourModel> filteredArmour = _filterArmour(appData.armours);

        return Scaffold(
          appBar: AppBar(title: Text("Armour")),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: [
                  _buildFilterDropdown('Tier', _selectedTier, _tiers, (val) {
                    setState(() {
                      _selectedTier = val!;
                    });
                  }),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredArmour.length,
                  itemBuilder: (context, index) {
                    final armourItem = filteredArmour[index];
                    return _buildArmourTile(armourItem);
                  },
                ),
              ),
            ],
          ),
        );
      }, //builder
    );
      /*
    return Scaffold(
      appBar: AppBar(
        title: Text('Armour'),
      ),
      body:
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    _searchQuery = value;
                    _applyFilters();
                  },
                  decoration: InputDecoration(
                    labelText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: [
                  _buildFilterDropdown('Tier', _selectedTier, _tiers, (val) {
                    _selectedTier = val!;
                    _applyFilters();
                  }),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredArmour.length,
                  itemBuilder: (context, index) {
                    final armourItem = _filteredArmour[index];
                    return ListTile(
                      leading: (armourItem.image != null)
                          ? SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(
                          'assets/images/${armourItem.image}',
                          fit: BoxFit.contain, // Fit inside box without cropping, keep aspect ratio
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.image_not_supported),
                        ),
                      )
                          : Icon(Icons.image_not_supported, size: 50),
                      title: Text(armourItem.name),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MarkdownWidget(
                              data: armourItem.feature,
                              config: darkFantasyMarkdownConfig, // from your custom config file
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              //config: MarkdownConfig.darkConfig,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '[${armourItem.baseScore} | ${armourItem.baseThreshold1} | ${armourItem.baseThreshold2} | Tier ${armourItem.tier}]',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey[400],
                                fontStyle: FontStyle.italic,
                              ), // style
                            ),
                          ] // children
                      ),
                      isThreeLine: true,
                    );
                  }, //itemBuilder
                ),
              ),
            ], // Children
          ),
      // body
    ); */
  } // build
}
