import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//imports
import '../patient_list/patient_list.dart';

// Create new patient form
class NewPatient extends StatefulWidget {
  const NewPatient({super.key});

  @override
  State<NewPatient> createState() => _NewPatientState();
}

class _NewPatientState extends State<NewPatient> {
  final _formKey = GlobalKey<FormState>();
  // name controller
  final nameController = TextEditingController();
  // surname controller
  final surnameController = TextEditingController();
  // date controller
  final dateController = TextEditingController();
  // gender
  String _genderValue = 'Select one';
  // gender list
  List<String> genderList = ['Select one', 'Female', 'Male'];

  // submit
  void _submitForm() {
    // form validation
    if (_formKey.currentState!.validate()) {
      final name = nameController.text;
      final surname = surnameController.text;
      final birthDate = dateController.text;
      final gender = _genderValue;

      final patientList = Provider.of<PatientList>(context, listen: false);
      patientList.addPatient(name, surname, birthDate, gender);
      // adding pop up message at correct submit
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Patient successfully added')),
      );
      // return to main page
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // name field
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Name *'),
                    // validation before sending request
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter patient's name";
                      }
                      return null;
                    }),
              ),
              // Surname field
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: surnameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Surname *'),
                    // validation before sending request
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter patient's surname";
                      }
                      return null;
                    }),
              ),
              // birthdate field
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: dateController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Birthdate *',
                      filled: true,
                      suffixIcon: Icon(Icons.calendar_today),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    readOnly: true,
                    onTap: () {
                      _selectDate();
                    },
                    // validation before sending request
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter patient's birthdate";
                      }
                      return null;
                    },
                  )),
              // Gender field
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Gender *',
                    ),
                    items: genderList.map((oneGender) {
                      return DropdownMenuItem(
                        value: oneGender,
                        child: SizedBox(child: Text(oneGender)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(
                        () {
                          _genderValue = value!;
                        },
                      );
                    },
                    value: _genderValue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    // validation before sending request
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value == 'Select one') {
                        return "Please enter patient's gender";
                      }
                      return null;
                    }),
              ),
              // Cancel / Submit buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Cancel (return to main page)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel')),
                  ),
                  // Submit (send info / execute _submitForm())
                  ElevatedButton(
                    onPressed: () {
                      _submitForm();
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ))
    ])));
  }

// Date selection function
// is an async/await function because we have to wait for users selection
  Future<void> _selectDate() async {
    var picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());

    if (picked != null) {
      var rawDate = picked;
      setState(() {
        dateController.text = DateFormat.yMMMMd().format(rawDate);
      });
    }
  }
}
