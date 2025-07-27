import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/database_helper.dart';
import 'dart:async';


class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final String cglCopyright = '''
This product includes materials from the Daggerheart System Reference Document 1.0, © Critical Role, LLC. All rights reserved.
''';

  final String cglAttribution = '''
This product includes Public Game Content created by Darrington Press (DRP).
More information: https://www.daggerheart.com
''';

  final String cglModification = '''
Public Game Content in this product is licensed under the Darrington Press Community Gaming License (CGL). See https://darringtonpress.com/license/ for details.
There are no previous modifications by others. [Or if modified: This product contains modifications made by the author.]
''';
  final String cglTrademark = '''
Darrington Press™ and the Darrington Press authorized work logo are trademarks of Critical Role, LLC and used with permission.
''';

  final String gplNotice = '''
This app is licensed under the GNU General Public License (GPL) version 3 or later.
You can find the full license text at: https://www.gnu.org/licenses/gpl-3.0.html
''';

  final String cglCardCreatorAttribution = '''
Cards created via the daggerheart.com card creator must display the following on the bottom of the card:
"Daggerheart™ Compatible. Terms at Daggerheart.com"
''';

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open URL')),
      );
    }
  }

  void _viewLogs() {
    // TODO: Implement your log viewer or navigate to a logs screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('View logs clicked')),
    );
  }

  void _importData() {
    // TODO: Implement your import functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Import clicked')),
    );
  }

  void _exportData() {
    // TODO: Implement your export functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Export clicked')),
    );
  }

  void _showResetDialog(BuildContext context) {
    int countdown = 5;
    Timer? timer;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            // Start timer only once
            if(timer == null) {
              timer = Timer.periodic(const Duration(seconds:1), (t) {
                if(countdown == 1) {
                  t.cancel();
                }
                setState(() {
                  countdown--;
                });
              });
            }

            final confirmEnabled = countdown <= 0;

            return AlertDialog(
              title: const Text('Confirm Reset'),
              content: Text(
                confirmEnabled
                    ? 'Are you sure you want to reset the database? This cannot be undone.'
                    : 'This will delete all characters and cards.\n\nYou can confirm in $countdown seconds.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: confirmEnabled
                      ? () async {
                    await DatabaseHelper.instance.resetDatabase();
                    if (context.mounted) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Database reset successfully'),
                        ),
                      );
                    }
                  }
                      : null,
                  child: const Text('Confirm'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Theme toggle
          ListTile(
            leading: Icon(widget.isDarkMode ? Icons.dark_mode : Icons.light_mode),
            title: const Text('Dark Theme WIP'),
            trailing: Switch(
              value: widget.isDarkMode,
              onChanged: (val) {
                widget.onThemeChanged(val);
              },
            ),
          ),
          const Divider(),

          // Import / Export
          ListTile(
            leading: const Icon(Icons.upload_file),
            title: const Text('Import Data WIP'),
            onTap: _importData,
          ),
          ListTile(
            leading: const Icon(Icons.download),
            title: const Text('Export Data WIP'),
            onTap: _exportData,
          ),
          const Divider(),

          // View logs
          ListTile(
            leading: const Icon(Icons.receipt_long),
            title: const Text('View Logs WIP'),
            onTap: _viewLogs,
          ),
          const Divider(),

          // Reset Database
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.redAccent),
            title: const Text('Reset Database'),
            subtitle: const Text('Deletes all cards and characters'),
            onTap: () => _showResetDialog(context),
          ),
          const Divider(),


          // Legal & Licensing Section Header
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text(
              'Legal & Licensing',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),

          // CGL Section
          Text(
            'Community Gaming Licence (CGL) - Daggerheart Content',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SelectableText(cglCopyright),
          const SizedBox(height: 4),
          SelectableText(cglAttribution),
          TextButton(
            onPressed: () => _launchUrl('https://www.daggerheart.com'),
            child: const Text('Visit daggerheart.com'),
          ),
          SelectableText(cglModification),
          TextButton(
              onPressed: () => _launchUrl('https://darringtonpress.com/license'),
              child: const Text('View Darrington Press Community Gaming License'),
          ),
          const SizedBox(height: 8),
          SelectableText(cglTrademark),
          const SizedBox(height: 8,),
          SelectableText(cglCardCreatorAttribution),
          const SizedBox(height: 24),

          Center(
            child: Column(
              children: [
                Text(
                  'Darrington Press Community Content Logo',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Image.asset(
                  'assets/images/DH_CGL_logos_final_full_color.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),

          // GPL Section
          Text(
            'GNU General Public License (GPL) - App Code',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(gplNotice),
          TextButton(
            onPressed: () => _launchUrl('https://www.gnu.org/licenses/gpl-3.0.html'),
            child: const Text('View GPL License Online'),
          ),
        ],
      ),
    );
  }
}