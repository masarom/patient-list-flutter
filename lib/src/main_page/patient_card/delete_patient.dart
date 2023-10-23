import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../patient_list/patient_list.dart';

// delete patient
void deletePatient(BuildContext context, int index) {
  final patientList = Provider.of<PatientList>(context, listen: false);
  patientList.removePatient(context, index);
}
