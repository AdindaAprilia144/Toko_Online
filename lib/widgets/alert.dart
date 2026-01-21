import 'package:flutter/material.dart';

class AlertMessage {
  showAlert(BuildContext context, String message, bool status) {
    Color warnaFill =
        status ? const Color(0xFFE8F5E9) : const Color(0xFFFFF3E0);
    Color warnaGaris =
        status ? Colors.green.shade700 : Colors.orange.shade700;

    IconData icon = status ? Icons.check_circle : Icons.warning_amber_rounded;

    SnackBar snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: warnaFill,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: warnaGaris, width: 2),
          boxShadow: const [
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: warnaGaris),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              child: const Icon(Icons.close, size: 18),
            ),
          ],
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
