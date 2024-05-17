import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                 child: _buildProfileImage(),
              ),
              _buildSettingItem(context, 'Personal Information'),
              _buildSettingItem(context, 'Emergency Contacts'),
              _buildSettingItem(context, 'Notification Preference'),
              _buildSettingItem(context, 'Other'),
              _buildSettingItem(context, 'Other'),
              _buildSettingItem(context, 'logout'),
            ],
          ),
          Positioned(
            bottom: 0, // Adjust the position as needed
            left: 0,
            right: 0,
            child: _buildLogoutButton(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(BuildContext context, String title) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        // Add your logic here for handling button taps
        switch (title) {
          case 'Personal Information':
          // Navigate to the personal information screen
            break;
          case 'Emergency Contacts':
          // Navigate to the emergency contacts screen
            break;
          case 'Notification Preference':
          // Navigate to the notification presence screen
            break;
          default:
            break;
        }
      },
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Add your logic here for handling the logout button tap
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
      child: const Text(
        'Logout',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      width: 120,
      height: 120,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.scaleDown,  // Use BoxFit.fill to show the entire image without cropping
          image: AssetImage('images/me.jpg'),
        ),
      ),
    );
  }

}
