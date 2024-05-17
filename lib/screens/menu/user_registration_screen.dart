import 'package:flutter/material.dart';

class UserRegistration extends StatelessWidget {
  const UserRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        appBar: AppBar(
          title: const Text('Add Your Details'),
          centerTitle: true,
        ),

        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Full name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter your full name',
                  border: OutlineInputBorder(), // Box style border
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'NIC',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter your NIC',
                  border: OutlineInputBorder(), // Box style border
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Mobile',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter your mobile number',
                  border: OutlineInputBorder(), // Box style border
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Email',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(), // Box style border
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  // Logic to save user details
                },
                child: const Text('Save User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
