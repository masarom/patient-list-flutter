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

    patients.add(newPatient);
    notifyListeners();
    print(patients);
  }

  // delete patients
  void removePatient(BuildContext context, int index) {
    patients.removeAt(index);
    notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Patient successfully removed')),
    );
  }

  // filter patients
  // copy of patient list for the filter search
  List<PatientCard> originalPatients = [];
  PatientList() {
    originalPatients = patients.toList();
  }

  void restoreOriginalList() {
    patients = originalPatients.toList();
    notifyListeners();
  }

  void filterPatients(BuildContext context, value) {
    final patientList = Provider.of<PatientList>(context, listen: false);
    if (value.isEmpty) {
      restoreOriginalList();
    } else {
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
