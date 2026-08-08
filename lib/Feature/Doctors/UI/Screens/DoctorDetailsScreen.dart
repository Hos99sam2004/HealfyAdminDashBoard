import 'package:flutter/material.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_details_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/UI/Widgets/doctor_detail_card.dart';

class Doctordetailsscreen extends StatefulWidget {
  final DoctorDetailsModel doctor;
  Doctordetailsscreen({super.key, required this.doctor});

  @override
  State<Doctordetailsscreen> createState() => _DoctordetailsscreenState();
}

class _DoctordetailsscreenState extends State<Doctordetailsscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Doctor Details Screen",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal.shade900,
      ),
      body: DoctorDetailCard(doctor: widget.doctor),
    );
  }
}
