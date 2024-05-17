import 'package:flutter/material.dart';
// import 'package:fluttertest/Screens/vehicle_info_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome note
            const Text(
              'Hi, Sadeesha...!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Emergency request button
            ElevatedButton(
              onPressed: () {

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),

                ),
                minimumSize: const Size(double.infinity, 70),

              ),
              child: const Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(Icons.warning, color: Colors.white,),
                  SizedBox(width: 8),
                  Text('Emergency Request' ,style: TextStyle(
                    color: Colors.white, // Change the text color to blue (or any other color)
                  ),)
                  ,
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Cancel Emergency button
            ElevatedButton(
              onPressed: () {
                // Add logic for canceling emergency
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),

                ),
                minimumSize: const Size(double.infinity, 70),
                // Adjust the width and height as needed
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(Icons.cancel, color: Colors.white,),
                  SizedBox(width: 8, height: 12,),
                  Text('Cancel Emergency',style: TextStyle(
                    color: Colors.white, // Change the text color to blue (or any other color)
                  ),),
                ],
              ),
            ),


            const SizedBox(height: 30),

            // Two rows of two buttons each
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLargeSquareButton('Notification', Icons.notifications, () {

            }),
          _buildLargeSquareButton('Emergency', Icons.warning, () {
            _showEmergencyRequestPopup(context);
          }),]),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLargeSquareButton('Vehicle', Icons.car_crash, () {
                  // VehicleInfo();
              // Add logic specific to Hospital button
            }),
        _buildLargeSquareButton('Other', Icons.help, () {
      // Add logic specific to Hospital button
    })
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create large square buttons with icons
  Widget _buildLargeSquareButton(String buttonText, IconData iconData,VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        fixedSize: const Size(150, 150), // Adjust the width and height as needed
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData,color: Colors.black, size: 40),
          const SizedBox(height: 8),
          Text(
            buttonText,
            textAlign: TextAlign.center,
            style: const TextStyle(
            color: Colors.black, // Set the text color to red
          ),

          ),
        ],
      ),
    );
  }
}
//popup message
void _showEmergencyRequestPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Emergency Request'),
        content: const Text('Choose an action:'),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSquareButton('Hospital', Icons.local_hospital, context),
              _buildSquareButton('Police', Icons.local_police, context),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSquareButton('Fire', Icons.fire_extinguisher, context),
              _buildSquareButton('Other', Icons.apps, context),
            ],
          ),
        ],
      );
    },
  );
}


Widget _buildSquareButton(String buttonText, IconData iconData, BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      // Add logic for each button
      Navigator.pop(context); // Close the popup
    },
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      fixedSize: const Size(130, 80), // Adjust the width and height as needed
    ),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(iconData, color: Colors.black, size: 22),
        const SizedBox(width: 5),
        Text(
          buttonText,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}



