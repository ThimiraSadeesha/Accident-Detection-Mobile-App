import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:async';
import '../../menu/emergencyContact.dart';
import '../../menu/notification.dart';
import '../../menu/vehicle_info_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                _showEmergencyRequestPopup(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                minimumSize: const Size(double.infinity, 90),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(Icons.warning, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Emergency Request',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add your cancel emergency logic here
                print('Cancel Emergency');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                minimumSize: const Size(double.infinity, 75),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(Icons.cancel, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Cancel Emergency',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLargeSquareButton('Notification', Icons.notifications,
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationScreen()),
                  );
                }),
                _buildLargeSquareButton('Emergency', Icons.warning, () {
                  _showEmergencyRequestPopup(context);
                }),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLargeSquareButton('Vehicle', Icons.car_crash, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const VehicleInfoScreen()),
                  );
                }),
                _buildLargeSquareButton('Emergency Persons', Icons.help, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EmergencyContactScreen()),
                  );
                }),
              ],
            ),
            const SizedBox(height: 40),
            _buildSlider(3), // Add the slider here
          ],
        ),
      ),
    );
  }

  Widget _buildLargeSquareButton(
      String buttonText, IconData iconData, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        fixedSize: const Size(150, 150),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData, color: Colors.black, size: 40),
          const SizedBox(height: 8),
          Text(
            buttonText,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }

  void _showEmergencyRequestPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Emergency Request'),
          content: const Text('Choose an action:'),
          actions: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSquareButton(
                        'Hospital', Icons.local_hospital, context),
                    _buildSquareButton('Police', Icons.local_police, context),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSquareButton(
                        'Fire', Icons.fire_extinguisher, context),
                    _buildSquareButton('Other', Icons.apps, context),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildSquareButton(
      String buttonText, IconData iconData, BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context); // Close the popup
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        fixedSize: const Size(130, 80),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(iconData, color: Colors.black, size: 22),
          const SizedBox(width: 5),
          Text(
            buttonText,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider(int itemCount) {
    return SizedBox(
      height: 150, // Adjust height according to your needs
      child: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        itemCount: itemCount, // Number of cards
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: _buildClimateCard(
              'Temperature: ${20 + index}°C',
              'Humidity: ${50 + index}%',
            ),
          );
        },
      ),
    );
  }

  Widget _buildClimateCard(String temperature, String humidity) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Climate Changes',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      temperature,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      humidity,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                  width: 40,
                  child: LineChart(
                    LineChartData(
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            const FlSpot(0, 1),
                            const FlSpot(1, 3),
                            const FlSpot(2, 2),
                            const FlSpot(3, 5),
                            const FlSpot(4, 4),
                          ],
                          isCurved: true,
                          color: Colors.red,
                          barWidth: 4,
                          belowBarData: BarAreaData(show: false),
                        ),
                      ],
                      titlesData: const FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      gridData: const FlGridData(show: false),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
