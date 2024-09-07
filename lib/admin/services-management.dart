import 'package:accident_detection_app/admin/services/fire.dart';
import 'package:accident_detection_app/admin/services/hospital.dart';
import 'package:accident_detection_app/admin/services/insurance.dart';
import 'package:accident_detection_app/admin/services/police.dart';
import 'package:flutter/material.dart';

class ServicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Emergency Services'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PoliceServicesPage()),
                );
              },
              child: Text('Manage Police Services'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HospitalServicesPage()),
                );
              },
              child: Text('Manage Hospital Services'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InsuranceServicesPage()),
                );
              },
              child: Text('Manage Insurance Services'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FireServicesPage()),
                );
              },
              child: Text('Manage Fire Services'),
            ),
          ],
        ),
      ),
    );
  }
}
