import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// imports
import './patient_list/patient_list.dart';
import './new_patient/new_patient.dart';
import './patient_card/patient_card.dart';

// colors
const appBarBackgroundColor = Color(0xFFEBEBEB);
const subtitleColor = Color(0x8b8b8bff);
const mainTextColor = Colors.black;
const darkContrastColor = Colors.white;

// Main page
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetching updated date for appbar
    final currentDate = DateTime.now();
    /* Simplified format:
        final formattedDate =
        '${currentDate.day}/${currentDate.month}/${currentDate.year}'; 
       Asked format: */
    final formattedDate = DateFormat.yMMMMd().format(currentDate);

    // context color
    final appBarTextColor = Theme.of(context).colorScheme.primary;

    // Appbar border
    const appBarBorder = 20.0;

    // patients list update
    final patientList = Provider.of<PatientList>(context);

    return Scaffold(
      // adding widgets to edit the AppBar styles (shadow, borders)
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Container(
          decoration: BoxDecoration(
            color: appBarBackgroundColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(appBarBorder),
              bottomRight: Radius.circular(appBarBorder),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                offset: const Offset(0, 4),
                blurRadius: 8.0,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(appBarBorder),
              bottomRight: Radius.circular(appBarBorder),
            ),
            child: AppBar(
              // adding a row to include different elements
              title: Row(
                // Making automatic space between elements
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Hi, Welcome', style: TextStyle(color: appBarTextColor)),
                  Text(formattedDate),
                ],
              ),
              backgroundColor: appBarBackgroundColor,
              // Toggle delete the "go back" default arrow
              automaticallyImplyLeading: false,
            ),
          ),
        ),
      ),
      // Content
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        // Main title
        const Padding(
          padding: EdgeInsets.only(top: 60.0, bottom: 8.0),
          child: Text(
            'Patient List',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        // Changing subtitle message with empty list and filled list
        Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 58.0),
            child: Text(
                patientList.patients.isEmpty
                    ? 'There are no patients in the list yet'
                    : 'Below you can find the list of registered patients. Select one to view more details or perform specific actions.',
                style: const TextStyle(
                  fontSize: 20,
                  color: subtitleColor,
                ),
                textAlign: TextAlign.center)),
        // Search bar
        Row(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 40.0),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Full name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      contentPadding: const EdgeInsets.all(13.0),
                      hintStyle: const TextStyle(
                          fontSize: 19.0, color: mainTextColor)),
                  onChanged: (value) {
                    patientList.filterPatients(context, value);
                  },
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 40.0),
              child: Container(
                decoration: BoxDecoration(
                    color: appBarTextColor, shape: BoxShape.circle),
                child: IconButton(
                  icon: const Icon(Icons.search, color: darkContrastColor),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
              itemCount: patientList.patients.length,
              itemBuilder: (context, index) {
                final patient = patientList.patients[index];
                return PatientCard(
                    index: index,
                    name: patient.name,
                    surname: patient.surname,
                    birthDate: patient.birthDate,
                    gender: patient.gender);
              }),
        ),
      ])),
      // add new patient icon
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 32.0),
        child: FloatingActionButton(
          backgroundColor: appBarTextColor,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const NewPatient()));
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: const Icon(
            Icons.add,
            color: darkContrastColor,
            size: 50.0,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
