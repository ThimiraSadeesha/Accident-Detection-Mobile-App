import 'package:flutter/material.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _nicController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _genderController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _districtController = TextEditingController();
  final _provinceController = TextEditingController();
  final _userPasswordController = TextEditingController();
  final _vehiclesController = TextEditingController();
  final _emergencyPersonsController = TextEditingController();
  final _devicesController = TextEditingController();

  int _currentStep = 0;

  void _nextStep() {
    if (_currentStep == 0 && _formKey1.currentState!.validate()) {
      setState(() {
        _currentStep = 1;
      });
    } else if (_currentStep == 1 && _formKey2.currentState!.validate()) {
      _submitForm();
    }
  }

  void _previousStep() {
    if (_currentStep == 1) {
      setState(() {
        _currentStep = 0;
      });
    }
  }

  void _submitForm() {
    // Perform the final registration logic here
    print("Form submitted");
    print("User Name: ${_userNameController.text}");
    print("Full Name: ${_fullNameController.text}");
    print("NIC: ${_nicController.text}");
    print("Contact Number: ${_contactNumberController.text}");
    print("Email: ${_emailController.text}");
    print("Gender: ${_genderController.text}");
    print("Address: ${_addressController.text}");
    print("City: ${_cityController.text}");
    print("District: ${_districtController.text}");
    print("Province: ${_provinceController.text}");
    print("User Password: ${_userPasswordController.text}");
    print("Vehicles: ${_vehiclesController.text}");
    print("Emergency Persons: ${_emergencyPersonsController.text}");
    print("Devices: ${_devicesController.text}");
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _fullNameController.dispose();
    _nicController.dispose();
    _contactNumberController.dispose();
    _emailController.dispose();
    _genderController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _districtController.dispose();
    _provinceController.dispose();
    _userPasswordController.dispose();
    _vehiclesController.dispose();
    _emergencyPersonsController.dispose();
    _devicesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _currentStep == 0 ? _buildStep1() : _buildStep2(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (_currentStep == 1)
              ElevatedButton(
                onPressed: _previousStep,
                child: const Text('Previous'),
              ),
            ElevatedButton(
              onPressed: _nextStep,
              child: Text(_currentStep == 0 ? 'Next' : 'Register'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep1() {
    return Form(
      key: _formKey1,
      child: ListView(
        children: <Widget>[
          TextFormField(
            controller: _userNameController,
            decoration: const InputDecoration(labelText: 'User Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your user name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _fullNameController,
            decoration: const InputDecoration(labelText: 'Full Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your full name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _nicController,
            decoration: const InputDecoration(labelText: 'NIC'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your NIC';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _contactNumberController,
            decoration: const InputDecoration(labelText: 'Contact Number'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your contact number';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _genderController,
            decoration: const InputDecoration(labelText: 'Gender'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your gender';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _addressController,
            decoration: const InputDecoration(labelText: 'Address'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your address';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _cityController,
            decoration: const InputDecoration(labelText: 'City'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your city';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _districtController,
            decoration: const InputDecoration(labelText: 'District'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your district';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _provinceController,
            decoration: const InputDecoration(labelText: 'Province'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your province';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _userPasswordController,
            decoration: const InputDecoration(labelText: 'User Password'),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStep2() {
    return Form(
      key: _formKey2,
      child: ListView(
        children: <Widget>[
          TextFormField(
            controller: _vehiclesController,
            decoration: const InputDecoration(labelText: 'Vehicles'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the number of vehicles';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _emergencyPersonsController,
            decoration: const InputDecoration(labelText: 'Emergency Persons'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the number of emergency persons';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _devicesController,
            decoration: const InputDecoration(labelText: 'Devices'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the number of devices';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
