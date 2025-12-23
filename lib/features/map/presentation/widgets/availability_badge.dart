import 'package:flutter/material.dart';

class AvailabilityBadge extends StatelessWidget {
  final bool available;

  const AvailabilityBadge({super.key, required this.available});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: available ? const Color(0xFF2ECC71) : const Color(0xFFE74C3C),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        available ? "Available" : "Not Available",
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }
}