import 'package:flutter/material.dart';
import 'package:news_app/core/app/my_app.dart';
import 'package:news_app/core/di/service_locator.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}
