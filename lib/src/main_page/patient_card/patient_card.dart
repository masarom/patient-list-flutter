import 'package:flutter/material.dart';

// imports
import 'delete_patient.dart';

//colors
const appBarBackgroundColor = Color(0xFFEBEBEB);
const mainTextColor = Colors.black;
const deleteColor = Color.fromARGB(255, 96, 11, 5);
const mainColor = Color.fromARGB(255, 0, 19, 43);

// Patients' cards
class PatientCard extends StatelessWidget {
  final int index;
  final String name;
  final String surname;
  final String birthDate;
  final String gender;

  const PatientCard({
    super.key,
    required this.index,
    required this.name,
    required this.surname,
    required this.birthDate,
    required this.gender,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      color: appBarBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: ListTile(
        title: Text(
          '$name $surname',
          style: const TextStyle(
            fontSize: 20.0,
            color: mainTextColor,
          ),
        ),
        subtitle: Text(
          'Birthdate: $birthDate\nGender: $gender',
          style: const TextStyle(
            fontSize: 20.0,
            color: mainTextColor,
          ),
        ),
        trailing: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const IconButton(
              icon: Icon(
                Icons.edit,
                size: 28.0,
              ),
              onPressed: editPatient,
            ),
            IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: deleteColor,
                  size: 28.0,
                ),
                onPressed: () {
                  deletePatient(context, index);
                }),
            const Icon(
              Icons.chevron_right,
              color: mainColor,
              size: 38.0,
            ),
          ],
        ),
        onTap: () {
          print('patient detail');
        },
      ),
    );
  }
}

// edit patient
void editPatient() {
  print('edit patient');
}
