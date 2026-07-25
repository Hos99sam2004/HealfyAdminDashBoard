import 'package:flutter/material.dart';

class StatisticsModel {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final Color backgroundColor;

  StatisticsModel({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.backgroundColor,
  });
}
