import 'package:flutter/material.dart';
import '../model/police-model.dart';


class PoliceServiceFormPage extends StatefulWidget {
  final PoliceService? service;

  PoliceServiceFormPage({this.service});

  @override
  _PoliceServiceFormPageState createState() => _PoliceServiceFormPageState();
}

class _PoliceServiceFormPageState extends State<PoliceServiceFormPage> {
  final _formKey = GlobalKey<FormState>();
  late String _policeCode, _policeName, _contactNumber, _city, _district, _province, _areaCovered;

  @override
  void initState() {
    super.initState();
    if (widget.service != null) {
      _policeCode = widget.service!.policeCode;
      _policeName = widget.service!.policeName;
      _contactNumber = widget.service!.contactNumber;
      _city = widget.service!.city;
      _district = widget.service!.district;
      _province = widget.service!.province;
      _areaCovered = widget.service!.areaCovered;
    } else {
      _policeCode = '';
      _policeName = '';
      _contactNumber = '';
      _city = '';
      _district = '';
      _province = '';
      _areaCovered = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.service == null ? 'Add Police Service' : 'Edit Police Service'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _policeCode,
                decoration: const InputDecoration(labelText: 'Police Code'),
                validator: (value) => value == null || value.isEmpty ? 'Enter Police Code' : null,
                onSaved: (value) => _policeCode = value!,
              ),
              TextFormField(
                initialValue: _policeName,
                decoration: InputDecoration(labelText: 'Police Name'),
                validator: (value) => value == null || value.isEmpty ? 'Enter Police Name' : null,
                onSaved: (value) => _policeName = value!,
              ),
              TextFormField(
                initialValue: _contactNumber,
                decoration: InputDecoration(labelText: 'Contact Number'),
                validator: (value) => value == null || value.isEmpty ? 'Enter Contact Number' : null,
                onSaved: (value) => _contactNumber = value!,
              ),
              TextFormField(
                initialValue: _city,
                decoration: InputDecoration(labelText: 'City'),
                validator: (value) => value == null || value.isEmpty ? 'Enter City' : null,
                onSaved: (value) => _city = value!,
              ),
              TextFormField(
                initialValue: _district,
                decoration: InputDecoration(labelText: 'District'),
                validator: (value) => value == null || value.isEmpty ? 'Enter District' : null,
                onSaved: (value) => _district = value!,
              ),
              TextFormField(
                initialValue: _province,
                decoration: InputDecoration(labelText: 'Province'),
                validator: (value) => value == null || value.isEmpty ? 'Enter Province' : null,
                onSaved: (value) => _province = value!,
              ),
              TextFormField(
                initialValue: _areaCovered,
                decoration: InputDecoration(labelText: 'Area Covered'),
                validator: (value) => value == null || value.isEmpty ? 'Enter Area Covered' : null,
                onSaved: (value) => _areaCovered = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: Text(widget.service == null ? 'Add Service' : 'Update Service'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final policeService = PoliceService(
        policeCode: _policeCode,
        policeName: _policeName,
        contactNumber: _contactNumber,
        city: _city,
        district: _district,
        province: _province,
        areaCovered: _areaCovered,
      );


      Navigator.pop(context, policeService);
    }
  }
}
