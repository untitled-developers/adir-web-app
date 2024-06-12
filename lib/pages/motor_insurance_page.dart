import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MotorInsurancePage extends StatefulWidget {
  const MotorInsurancePage({super.key});

  @override
  State<MotorInsurancePage> createState() => _MotorInsurancePageState();
}

class _MotorInsurancePageState extends State<MotorInsurancePage> {
  final ImagePicker _picker = ImagePicker();
  List<File?> images = [null, null, null, null, null, null, null, null];

  Future<void> _pickImage(int index) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() => images[index] = File(pickedFile.path));
    }
  }

  Widget _buildImageTemplate(int i) {
    return GestureDetector(
      onTap: () => _pickImage(i),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: images[i] == null
            ? Image.asset('assets/images/temp${i + 1}.png', fit: BoxFit.cover)
            : Image.network(images[i]!.path, fit: BoxFit.cover),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Motor Insurance')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                  'To activate your coverage, simply capture the required photos by clicking on the images below.'),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: 8,
                itemBuilder: (context, index) => _buildImageTemplate(index),
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: () {}, child: const Text('Upload'))
            ],
          ),
        ),
      ),
    );
  }
}
