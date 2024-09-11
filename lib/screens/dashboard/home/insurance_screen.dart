import 'package:flutter/material.dart';

class InsuranceScreen extends StatelessWidget {
  const InsuranceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Insurance',style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.call,color: Colors.white,),
            onPressed: () {
              _showCallOptions(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInsuranceDetailCard(),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddInsuranceScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                fixedSize: const Size(40, 45),
              ),
              child: const Text(
                'Add Insurance',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildInsuranceDetailCard() {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Insurance Name: Home Insurance',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Town: Springfield',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            _buildActionButton('Report an Accident', Icons.report, () {
              // Navigate to the accident report screen
            }),
            SizedBox(height: 12),
            _buildActionButton('Request Help', Icons.help, () {
              // Navigate to the help request screen
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, VoidCallback onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(label),
    );
  }

  void _showCallOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Voice Call'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.video_call),
              title: Text('Video Call'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
class AddInsuranceScreen extends StatefulWidget {
  @override
  _AddInsuranceScreenState createState() => _AddInsuranceScreenState();
}

class _AddInsuranceScreenState extends State<AddInsuranceScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController _insuranceCodeController = TextEditingController();
  final TextEditingController _insuranceNameController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _areaCoveredController = TextEditingController();

  String _selectedInsurance = 'Select Insurance';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Add Insurance',style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
                value: _selectedInsurance,
                items: [
                  DropdownMenuItem(child: Text('Select Insurance'), value: 'Select Insurance'),
                  DropdownMenuItem(child: Text('Home Insurance'), value: 'Home Insurance'),
                  DropdownMenuItem(child: Text('Auto Insurance'), value: 'Auto Insurance'),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedInsurance = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Insurance Type'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _insuranceCodeController,
                decoration: InputDecoration(labelText: 'Insurance Code'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _insuranceNameController,
                decoration: InputDecoration(labelText: 'Insurance Name'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _contactNumberController,
                decoration: InputDecoration(labelText: 'Contact Number'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(labelText: 'City'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _districtController,
                decoration: InputDecoration(labelText: 'District'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _provinceController,
                decoration: InputDecoration(labelText: 'Province'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _areaCoveredController,
                decoration: InputDecoration(labelText: 'Area Covered'),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  fixedSize: const Size(40, 45),
                ),
                child: const Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
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
