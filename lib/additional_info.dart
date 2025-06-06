import 'package:flutter/material.dart';


class AdditionalInfoCard extends StatelessWidget {
final IconData icon;
final String label;
final String value;



  const AdditionalInfoCard({super.key, required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, size: 32),
            const SizedBox(height: 8),

            Text(label),
            SizedBox(height: 8),

            Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
