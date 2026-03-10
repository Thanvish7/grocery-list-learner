import 'package:flutter/material.dart';

class EmptyListPlaceholder extends StatelessWidget {
  const EmptyListPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🥦', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 12),
          Text('Your list is empty',
              style:
                  theme.textTheme.titleMedium?.copyWith(color: Colors.grey)),
          Text('Add something above!',
              style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey)),
        ],
      ),
    );
  }
}
