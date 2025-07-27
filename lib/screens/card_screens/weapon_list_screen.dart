/*
 * This file is part of The Codex Ledger.
 *
 * The Codex Ledger is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * The Codex Ledger is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with The Codex Ledger.  If not, see <https://www.gnu.org/licenses/>.
 */

//import 'dart:ffi';

import 'package:daggerheart/models/weapon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_data_provider.dart';
import 'package:markdown_widget/markdown_widget.dart';
import '../../theme/markdown_theme.dart';
//import '../../utils/debug_utils.dart'; // adjust path as needed

class WeaponListScreen extends StatefulWidget {

  const WeaponListScreen ({
    super.key,
  });

  @override
  State <WeaponListScreen> createState() => _WeaponListScreenState();
}

class _WeaponListScreenState extends State<WeaponListScreen> {
  final List<int> _tiers = [0, 1,2,3,4,5];

  String _searchQuery = '';
  int _selectedTier = 0; // 0 means "no tier filter"

  List<WeaponModel> _filterWeapons(List<WeaponModel> weaponsList) {
    return weaponsList.where((weaponItem) {
      final matchesTier = _selectedTier == 0 || weaponItem.tier == _selectedTier;
      final matchesSearch = _searchQuery.isEmpty ||
          weaponItem.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          weaponItem.feature.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesTier && matchesSearch;
    }).toList();
  }

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

  Widget _buildWeaponTile(WeaponModel weaponItem) {
    final theme = Theme.of(context);

    return ListTile(
      leading: (weaponItem.image != null)
          ? SizedBox(
        width: 50,
        height: 50,
        child: Image.asset(
          'assets/images/${weaponItem.image}',
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) =>
              Icon(Icons.image_not_supported),
        ),
      )
          : Icon(Icons.image_not_supported, size: 50),
      title: Text(weaponItem.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MarkdownWidget(
            data: weaponItem.feature,
            config: buildMarkdownConfigFromTheme(theme),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
          ),
          const SizedBox(height: 4),
          Text(
            '[${weaponItem.type} | Tier ${weaponItem.tier}]',
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
            appBar: AppBar(title: Text("Weapons")),
            body: Center(child: CircularProgressIndicator(),),
          );
        } // if

        final List<WeaponModel> filteredWeapons = _filterWeapons(appData.weapons);

        return Scaffold(
          appBar: AppBar(title: Text("Weapons")),
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
                  itemCount: filteredWeapons.length,
                  itemBuilder: (context, index) {
                    final weaponItem = filteredWeapons[index];
                    return _buildWeaponTile(weaponItem);
                  },
                ),
              ),
            ],
          ),
        );
      }, //builder
    );
  } // build
}
