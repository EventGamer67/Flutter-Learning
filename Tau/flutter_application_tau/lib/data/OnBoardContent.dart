import 'package:flutter/material.dart';

class OnboardPageContent {
  IconData icon;
  String title;

  OnboardPageContent({
    required this.icon,
    required this.title,
  });
}

List<OnboardPageContent> contents = [
  OnboardPageContent(
    title: "Hello, Li",
    icon: Icons.abc
  ),
  OnboardPageContent(
    title: "How are you?",
    icon: Icons.ac_unit
  ),
  OnboardPageContent(
    title: "Welcome here",
    icon: Icons.access_alarm
  ),
];