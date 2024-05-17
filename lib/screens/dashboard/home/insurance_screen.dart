import 'package:flutter/material.dart';

class InsuranceScreen extends StatelessWidget {
  const InsuranceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Insurance',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        primary: false, // Set primary to false to remove extra space
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 15.0), // Adjust the top padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildUserProfileSection(),
            SizedBox(height: 12),
            _buildUpdateButton(context),
            SizedBox(height: 12),
            _buildPolicyPlansSection(),
            SizedBox(height: 12),
            _buildFileClaimSection(context, 'Report an accident'),
            _buildFileClaimSection(context, 'Submit a medical claim'),
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfileSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            _buildProfileImage(),
            // You can add an edit icon or any other overlay on the image if needed
          ],
        ),
        SizedBox(height: 10),
        Text(
          'Emma Watson',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Member since 2019',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildUpdateButton(BuildContext context) {
    return ElevatedButton(

      onPressed: () {
        // Navigate to the user profile editing screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserProfileEditingScreen()),
        );
      },
      child: Text('Update'),
    );
  }

  Widget _buildPolicyPlansSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Policy Plans',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        _buildPolicyCard('Home insurance', 'View policy', '\$500'),
        _buildPolicyCard('Auto insurance', 'View policy', '\$700'),
      ],
    );
  }

  Widget _buildPolicyCard(String policyType, String buttonText, String annualPremium) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(policyType),
        subtitle: Text('Annual Premium: $annualPremium'),
        trailing: ElevatedButton(
          onPressed: () {
            // Navigate to a screen with detailed policy information
            // You can implement the navigation logic here
          },
          child: Text(buttonText),
        ),
      ),
    );
  }

  Widget _buildFileClaimSection(BuildContext context, String title) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        // Add your logic here for handling button taps
        switch (title) {
          case 'Report an accident':
          // Navigate to the screen for reporting an accident
            break;
          case 'Submit a medical claim':
          // Navigate to the screen for submitting a medical claim
            break;

          default:
            break;
        }
      },
    );
  }

  Widget _buildProfileImage() {
    return Container(
      width: 100,
      height: 100,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('images/me.jpg'),
        ),
      ),
    );
  }
}

class UserProfileEditingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildProfileImageView(),
            const SizedBox(height: 16),
            const Text('User Profile Editing Screen'),
          ],
        ),
      ),
    );
  }
  Widget _buildProfileImageView() {
    return Container(
      width: 180,
      height: 180,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('images/me.jpg'),
        ),
      ),
    );
  }
}
