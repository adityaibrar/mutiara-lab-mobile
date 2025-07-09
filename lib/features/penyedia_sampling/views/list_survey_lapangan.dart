import 'package:flutter/material.dart';

class ListSurveyLapangan extends StatelessWidget {
  static const String routeName = '/list-survey-lapangan';
  const ListSurveyLapangan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List Survey Lapangan')),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                colors: [Color(0xFF0F172A), Color(0xFF1E3A8A)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
