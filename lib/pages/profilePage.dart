import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../firebase/auth.dart';
import 'package:MyMeteo/providers/themeProvider.dart';
import '../firebase/firebase_analytics.dart';
import '../providers/themeProvider.dart';

class ProfilePage extends StatelessWidget {
  Future<void> logout() async {
    await Auth().signOut();
  }

  void logLogoutEvent() {
    AnalyticsService.analytics.logEvent(
      name: 'logout',
    );
  }

  void logTestEvent() {
    AnalyticsService.analytics.logEvent(
      name: 'settings',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(top: 32),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                radius: 80.0,
                backgroundImage: NetworkImage('https://picsum.photos/200'),
              ),
              const SizedBox(height: 16),
              Text(
                'John Doe',
                style: TextStyle(
                  fontSize: 32,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FloatingActionButton(
                onPressed: () {
                  final themeModel =
                      Provider.of<ThemeModel>(context, listen: false);
                  themeModel.toggleTheme();
                },
                child: Icon(
                  context.watch<ThemeModel>().isDarkMode
                      ? Icons.wb_sunny
                      : Icons.nightlight_round,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: navigate to edit profile page
                },
                icon: Icon(Icons.edit),
                label: const Text('Edit Profile'),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.secondary,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: navigate to settings page
                  logTestEvent();
                },
                icon: Icon(Icons.settings),
                label: const Text('Settings'),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.secondary,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  logLogoutEvent();
                  logout();
                },
                icon: Icon(Icons.logout),
                label: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.error,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
