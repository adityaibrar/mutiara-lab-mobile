import 'package:flutter/material.dart';

class ListDocumentQuotation extends StatelessWidget {
  static const String routeName = '/list-dokumen-quotation';
  const ListDocumentQuotation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List Dokumen Quotation')),
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
