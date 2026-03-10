import 'package:flutter/material.dart';

class AddItemBar extends StatelessWidget {
  final TextEditingController controller;
  final List<String> suggestions;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onAddPressed;

  const AddItemBar({
    super.key,
    required this.controller,
    required this.suggestions,
    required this.onChanged,
    required this.onSubmitted,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2E7D32),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  onChanged: onChanged,
                  onSubmitted: onSubmitted,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Add an item...',
                    hintStyle: const TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: Colors.white12,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: onAddPressed,
                icon:
                    const Icon(Icons.add_circle, color: Colors.white, size: 36),
              ),
            ],
          ),
          if (suggestions.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Wrap(
                spacing: 8,
                children: suggestions
                    .map((s) => GestureDetector(
                          onTap: () => onSubmitted(s),
                          child: Chip(
                            label: Text(s),
                            backgroundColor: Colors.white,
                            labelStyle: const TextStyle(color: Color(0xFF2E7D32), fontWeight: FontWeight.w600),
                            avatar: const Icon(Icons.history,
                                size: 14, color: Color(0xFF2E7D32)),
                          ),
                        ))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}