import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  final Dio _dio = Dio();

  @override
  void dispose() {
    // Dispose all controllers to avoid memory leaks
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
    super.dispose();
  }

  Future<void> _saveVehicleDetails() async {
    // try {
    final response = await _dio.post(
      'http://192.168.8.103:3000/vehicle',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
      data: {
        'vehicleNumber': '',
        'manufactureYear': '',
        'vehicleType': '',
        'vehicleModel': '',
      },
    );

    if (response.statusCode == 201) {
      print(response.statusCode);
      Fluttertoast.showToast(
        msg: 'Vehicle details saved successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      // _clearFields();


      // } catch (e) {
      //   print(e);
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Form'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              _buildTextField(_userNameController, 'Username',
                  'Please enter your username'),
              _buildTextField(_fullNameController, 'Full Name',
                  'Please enter your full name'),
              _buildTextField(_nicController, 'NIC', 'Please enter your NIC'),
              _buildTextField(_contactNumberController, 'Contact Number',
                  'Please enter your contact number'),
              _buildTextField(
                  _emailController, 'Email', 'Please enter a valid email',
                  isEmail: true),
              _buildTextField(
                  _genderController, 'Gender', 'Please enter your gender'),
              _buildTextField(
                  _addressController, 'Address', 'Please enter your address'),
              _buildTextField(
                  _cityController, 'City', 'Please enter your city'),
              _buildTextField(_districtController, 'District',
                  'Please enter your district'),
              _buildTextField(_provinceController, 'Province',
                  'Please enter your province'),
              _buildTextField(_userPasswordController, 'Password',
                  'Please enter a secure password', isPassword: true),
              _buildTextField(
                  _vehiclesController, 'Vehicles', 'Enter number of vehicles'),
              _buildTextField(_emergencyPersonsController, 'Emergency Persons',
                  'Enter number of emergency persons'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveVehicleDetails,

                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText,
      String validationMessage,
      {bool isEmail = false, bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        obscureText: isPassword,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validationMessage;
          }
          if (isEmail && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
            return 'Please enter a valid email';
          }
          return null;
        },
      ),
    );
  }
}
