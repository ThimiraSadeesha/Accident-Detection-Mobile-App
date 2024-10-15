import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../menu/emergencyContact.dart';
import '../../menu/notification.dart';
import '../../menu/vehicle_info_screen.dart';
import '../../user/location_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController();
  String _locationMessage = "";
  final LocationService _locationService = LocationService();
  int _currentPage = 0;
  late Timer _timer;
  List<Map<String, String>> climateData = [
    {'temperature': 'Loading...'},
    {'temperature': 'Loading...'},
  ];

  Future<void> _getCurrentLocation() async {
    Position? position = await _locationService.getCurrentLocation();
    if (position != null) {
      setState(() {
        _locationMessage = "${position.latitude},${position.longitude}";
      });
      _locationService.getLocationStream().listen((Position position) {
        setState(() {
          "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
        });
      });
    } else {
      setState(() {
        _locationMessage = "Location permissions are denied";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
    _startClimateDataUpdate();
    _getCurrentLocation();
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

  Future<void> fetchClimateData() async {
    const apiUrl =
        'https://api.open-meteo.com/v1/forecast?latitude=6.842696&longitude=80.017209&current=temperature_2m,relative_humidity_2m';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final temperature = '${data['current']['temperature_2m']}°C';
        final humidity = '${data['current']['relative_humidity_2m']}%';

        setState(() {
          // Update all slots with the same climate data for now
          for (int i = 0; i < climateData.length; i++) {
            climateData[i] = {
              'temperature': temperature,

            };
          }
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  void _startClimateDataUpdate() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      fetchClimateData();
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
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                _getCurrentLocation();
                requestEmergency('high', _locationMessage, 'pending', 1);
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
            const SizedBox(height: 10),
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
                        builder: (context) => NotificationScreen()),
                  );
                }),
                _buildLargeSquareButton('Emergency', Icons.warning, () {
                  _showEmergencyRequestPopup(context);
                }),
              ],
            ),
            const SizedBox(height: 20),
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
            _buildSlider(climateData.length),
            // Slider now displays live climate data
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
          Icon(iconData, color: Colors.black, size: 35),
          const SizedBox(height: 5),
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
      height: 180, // Adjust height according to your needs
      child: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        itemCount: itemCount, // Number of cards
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: _buildClimateCard(
              climateData[index]['temperature']!
            ),
          );
        },
      ),
    );
  }

  Widget _buildClimateCard(String temperature) {
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
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      temperature,
                      style: const TextStyle(fontSize: 18),
                    ),s
                  ],
                ),
                SizedBox(
                  height: 40,
                  width: 30,
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
                      'Medi',
                      Icons.local_hospital,
                          () => _handleMediAction('medium'),
                      context,
                    ),
                    _buildSquareButton(
                      'Police',
                      Icons.local_police,
                          () =>  _handleMediAction('medium'),
                      context,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSquareButton(
                      'Fire',
                      Icons.fire_extinguisher,
                      () => _handleMediAction('medium'),
                      context,
                    ),
                    _buildSquareButton(
                      'Other',
                      Icons.apps,
                          () => _handleMediAction('medium'),
                      context,
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  _handleMediAction(String severity) {
    requestEmergency(severity, _locationMessage, 'active', 1);
  }

  void requestEmergency(String severity, String location, String incidentStatus,
      int deviceId) async {
    try {
      Dio dio = Dio();
      Response response = await dio.post(
        'http://192.168.8.184:3000/accident',
        data: {
          'severity': severity,
          'location': location,
          'incidentStatus': incidentStatus,
          'deviceId': deviceId,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      // Handle success response
      Fluttertoast.showToast(
        msg: 'Emergency Requested',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      // Handle error
      Fluttertoast.showToast(
        msg: 'Failed to request emergency',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  // void requestEmergency() async {
  //   Dio dio = Dio();
  //   Response response = await dio.post(
  //     'http://192.168.8.184:3000/accident',
  //     data: {
  //   'severity':'high',
  //   'location':'',
  //   'incidentStatus':'pending',
  //   'deviceId':1,
  //
  //   },
  //     options: Options(
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //     ),
  //   );
  //
  //
  //   Fluttertoast.showToast(
  //     msg: 'Emergency  Requested',
  //     toastLength: Toast.LENGTH_SHORT,
  //     gravity: ToastGravity.BOTTOM,
  //     backgroundColor: Colors.green,
  //     textColor: Colors.white,
  //     fontSize: 16.0,
  //   );
  // }

  Widget _buildSquareButton(String buttonText, IconData iconData,
      VoidCallback onPressed, BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        fixedSize: const Size(120, 60),
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
}

//
//   Future<void> _getCurrentLocation() async {
//     var status = await Permission.locationWhenInUse.request();
//     if (status.isGranted) {
//       Position position = await Geolocator.getCurrentPosition(
//           locationSettings: LocationSettings(
//               accuracy: LocationAccuracy.high, distanceFilter: 10));
//       setState(() {
//         _locationMessage =
//         "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
//       });
//       Geolocator.getPositionStream(
//           locationSettings: const LocationSettings(
//               accuracy: LocationAccuracy.best, distanceFilter: 10))
//           .listen((Position position) {
//         setState(() {
//           _locationMessage =
//           "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
//         });
//       });
//     } else {
//       setState(() {
//         _locationMessage = "Location permissions are denied";
//       });
//     }
//   }
// }
