import 'package:accident_detection_app/screens/menu/notification.dart';
import 'package:accident_detection_app/screens/menu/vehicle_info_screen.dart';
import 'package:flutter/material.dart';
import '../../menu/emergencyContact.dart';
import '../../user/user-registration.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildProfileImage(),
              ),
              _buildSettingItem(context, 'Personal Information'),
              _buildSettingItem(context, 'Emergency Contacts'),
              _buildSettingItem(context, 'Notification Preference'),
              _buildSettingItem(context, 'Vehicle Preference'),
              _buildSettingItem(context, 'Map'),
              _buildSettingItem(context, 'Settings'),
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
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        switch (title) {
          case 'Personal Information':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  RegistrationScreen()),
            );
            break;
          case 'Emergency Contacts':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EmergencyContactScreen()),
            );
            break;
          case 'Notification Preference':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotificationScreen()),
            );
            break;
            case 'Vehicle Preference':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const VehicleInfoScreen()),
            );
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
          fit: BoxFit.scaleDown, // Changed to BoxFit.cover for better image fit
          image: AssetImage('images/me.jpg'),
        ),
      ),
    );
  }
}
