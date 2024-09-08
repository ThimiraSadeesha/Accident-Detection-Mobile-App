import 'package:flutter/material.dart';
import 'forms/police-form.dart';
import 'model/police-model.dart';


class PoliceServicesPage extends StatefulWidget {
  @override
  _PoliceServicesPageState createState() => _PoliceServicesPageState();
}

class _PoliceServicesPageState extends State<PoliceServicesPage> {
  List<PoliceService> policeServices = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Police Servicess'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final newService = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PoliceServiceFormPage()),
              );
              if (newService != null) {
                setState(() {
                  policeServices.add(newService);
                });
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: policeServices.length,
        itemBuilder: (context, index) {
          final service = policeServices[index];
          return ListTile(
            title: Text(service.policeName),
            subtitle: Text('Code: ${service.policeCode}\nContact: ${service.contactNumber}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () async {
                    final updatedService = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PoliceServiceFormPage(service: service),
                      ),
                    );
                    if (updatedService != null) {
                      setState(() {
                        policeServices[index] = updatedService;
                      });
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      policeServices.removeAt(index);
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
