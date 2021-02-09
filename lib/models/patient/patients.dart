import 'package:health_care/models/patient/patient.dart';
import 'package:flutter/material.dart';

class Patients with ChangeNotifier {
  List<Patient> _items = [
    Patient(
      name: "John Doe",
      profileImage:
          "https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg",
      procedure: "Plastic surgery",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
      amount: 25000.0,
    ),
    Patient(
      name: "John Doe",
      profileImage:
          "https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg",
      procedure: "Plastic surgery",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
      amount: 25000.0,
    ),
    Patient(
      name: "John Doe",
      profileImage:
          "https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg",
      procedure: "Plastic surgery",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
      amount: 25000.0,
    ),
    Patient(
      name: "John Doe",
      profileImage:
          "https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg",
      procedure: "Plastic surgery",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
      amount: 25000.0,
    ),
    Patient(
      name: "John Doe",
      profileImage:
          "https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg",
      procedure: "Plastic surgery",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
      amount: 25000.0,
    ),
    Patient(
      name: "John Doe",
      profileImage:
          "https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg",
      procedure: "Plastic surgery",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
      amount: 25000.0,
    ),
    Patient(
      name: "John Doe",
      profileImage:
          "https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg",
      procedure: "Plastic surgery",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
      amount: 25000.0,
    ),
    Patient(
      name: "John Doe",
      profileImage:
          "https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg",
      procedure: "Plastic surgery",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
      amount: 25000.0,
    ),
    Patient(
      name: "John Doe",
      profileImage:
          "https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg",
      procedure: "Plastic surgery",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
      amount: 25000.0,
    ),
  ];

  List<Patient> get items {
    return _items.toList();
  }
}
