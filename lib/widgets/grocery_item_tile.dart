import 'package:flutter/material.dart';
import '../models/grocery_item.dart';

class GroceryItemTile extends StatelessWidget {
  final GroceryItem item;
  final int index;
  final int frequency;
  final VoidCallback onToggle;
  final VoidCallback onDismiss;

  const GroceryItemTile({
    super.key,
    required this.item,
    required this.index,
    required this.frequency,
    required this.onToggle,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(item.name),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red.shade400,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => onDismiss(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          leading: Checkbox(
            value: item.isChecked,
            onChanged: (_) => onToggle(),
            activeColor: const Color(0xFF2E7D32),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          title: Text(
            item.name,
            style: TextStyle(
              fontSize: 16,
              decoration: item.isChecked ? TextDecoration.lineThrough : null,
              color: item.isChecked ? Colors.grey : Colors.black87,
            ),
          ),
          trailing: frequency >= 3
              ? Tooltip(
                  message: 'Bought $frequency times',
                  child: const Icon(Icons.star, size: 16, color: Colors.amber),
                )
              : null,
        ),
      ),
    );
  }
}