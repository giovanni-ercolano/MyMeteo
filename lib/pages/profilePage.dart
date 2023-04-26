import 'package:flutter/material.dart';
import '../firebase/auth.dart';

class ProfilePage extends StatelessWidget {
  Future<void> logout() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
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
