
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Profile Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StudentProfileForm(),
    );
  }
}

class StudentProfileForm extends StatefulWidget {
  const StudentProfileForm({super.key});

  @override
  State<StudentProfileForm> createState() =>
      _StudentProfileFormState();
}

class _StudentProfileFormState
    extends State<StudentProfileForm> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final addressController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();

  String? gender;
  Map<String, String>? student;

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        student = {
          'Full Name': nameController.text,
          'Age': ageController.text,
          'Gender': gender!,
          'Address': addressController.text,
          'Contact Number': contactController.text,
          'Email': emailController.text,
        };
      });
    }
  }

  void clearForm() {
    _formKey.currentState!.reset();

    nameController.clear();
    ageController.clear();
    addressController.clear();
    contactController.clear();
    emailController.clear();

    setState(() {
      gender = null;
      student = null;
    });
  }

  Widget buildField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter your $label';
          }
          return null;
        },
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    addressController.dispose();
    contactController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Profile Form'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  buildField('Full Name', nameController),
                  buildField(
                    'Age',
                    ageController,
                    keyboardType: TextInputType.number,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: DropdownButtonFormField<String>(
                      value: gender,
                      decoration: const InputDecoration(
                        labelText: 'Gender',
                        border: OutlineInputBorder(),
                      ),
                      items: ['Male', 'Female', 'Other']
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          gender = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select your gender';
                        }
                        return null;
                      },
                    ),
                  ),

                  buildField('Address', addressController),
                  buildField(
                    'Contact Number',
                    contactController,
                    keyboardType: TextInputType.phone,
                  ),
                  buildField(
                    'Email',
                    emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: submitForm,
                          child: const Text('Submit'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: clearForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Clear / Reset'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            if (student != null) ...[
              const SizedBox(height: 25),
              const Text(
                'Student Information',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: student!.entries.map((entry) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(bottom: 10),
                        child: Text(
                          '${entry.key}: ${entry.value}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}