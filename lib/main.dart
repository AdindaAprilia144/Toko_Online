import 'package:flutter/material.dart';
import 'package:toko_online/viewes/dashboard_view.dart';
import 'package:toko_online/viewes/login_view.dart';
import 'package:toko_online/viewes/register_user_view.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/': (context) => RegisterUserView(),
        '/login': (context) => LoginView(),
        '/dashboard': (context) => DashboardView(), 
        },
    ),
  );
}
