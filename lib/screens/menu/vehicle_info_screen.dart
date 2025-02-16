import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VehicleInfoScreen extends StatefulWidget {
  const VehicleInfoScreen({Key? key}) : super(key: key);

  @override
  _VehicleInfoScreenState createState() => _VehicleInfoScreenState();
}

class _VehicleInfoScreenState extends State<VehicleInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  final _vehicleNumberController = TextEditingController();
  final _manufactureYearController = TextEditingController();
  final _vehicleModelController = TextEditingController();
  String? _selectedVehicleType;

  static const List<String> vehicleTypes = [
    'Car',
    'Motorcycle',
    'Truck',
    'Bus',
    'Van',
    'Other',
  ];

  final Dio _dio = Dio();

  void _clearFields() {
    _vehicleNumberController.clear();
    _manufactureYearController.clear();
    _vehicleModelController.clear();
    setState(() {
      _selectedVehicleType = null;
    });
  }

  Future<void> _saveVehicleDetails() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await _dio.post(
          'http://192.168.8.103:3000/vehicle',
          options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
          ),
          data: {
            'vehicleNumber': _vehicleNumberController.text,
            'manufactureYear': _manufactureYearController.text,
            'vehicleType': _selectedVehicleType,
            'vehicleModel': _vehicleModelController.text,
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
          _clearFields();

        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.red,
        title: const Text(
          'Add Vehicle Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Vehicle Model',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                TextFormField(
                  controller: _vehicleModelController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Vehicle Model',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Vehicle Type',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                DropdownButtonFormField<String>(
                  value: _selectedVehicleType,
                  hint: const Text('Select Vehicle Type'),
                  isExpanded: true,
                  items: vehicleTypes.map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedVehicleType = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a vehicle type';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  'Vehicle Number',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                TextFormField(
                  controller: _vehicleNumberController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Vehicle Number',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the vehicle number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  'Manufacture Year',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                TextFormField(
                  controller: _manufactureYearController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Manufacture Year',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the manufacture year';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _clearFields,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          fixedSize: const Size(40, 45),
                        ),
                        child: const Text(
                          'Clear',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _saveVehicleDetails,
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
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _vehicleNumberController.dispose();
    _manufactureYearController.dispose();
    _vehicleModelController.dispose();
    super.dispose();
  }
}
