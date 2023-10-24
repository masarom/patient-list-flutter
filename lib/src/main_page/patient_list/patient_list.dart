import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//imports
import '../patient_card/patient_card.dart';

// patients' list
class PatientList extends ChangeNotifier {
  List<PatientCard> patients = [];

  // add new patient
  void addPatient(
      String name, String surname, String birthDate, String gender) {
    final newPatient = PatientCard(
      index: patients.length - 1,
      name: name,
      surname: surname,
      birthDate: birthDate,
      gender: gender,
    );
    // adding new patient too the list
    patients.add(newPatient);
    // notify the rest of widgets
    notifyListeners();
  }

  // delete patients
  void removePatient(BuildContext context, int index) {
    // remove patient corresponding to the index
    patients.removeAt(index);
    notifyListeners();
    // pop up message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Patient successfully removed')),
    );
  }

  // filter patients
  // copy of patient list for the filter search to avoid removal of patients while searching
  List<PatientCard> originalPatients = [];
  PatientList() {
    originalPatients = patients.toList();
  }
  // function to call the copy with the whole list of patients when the search is empty
  void restoreOriginalList() {
    patients = originalPatients.toList();
    notifyListeners();
  }

  void filterPatients(BuildContext context, value) {
    final patientList = Provider.of<PatientList>(context, listen: false);
    // calling the entire list of patients when search is empty
    if (value.isEmpty) {
      restoreOriginalList();
    } else {
      // filter patients by name or surname
      List<PatientCard> filteredPatients =
          patientList.patients.where((patient) {
        final fullName = '${patient.name} ${patient.surname}'.toLowerCase();
        return fullName.contains(value.toLowerCase());
      }).toList();
      patients = filteredPatients;
      notifyListeners();
    }
  }
}
