import 'package:flutter/material.dart';
import '../models/grocery_item.dart';
import '../services/storage_service.dart'; 
import '../services/suggestion_service.dart';
import '../widgets/add_item_bar.dart';
import '../widgets/grocery_item_tile.dart';
import '../widgets/empty_list_placeholder.dart';

class GroceryHomePage extends StatefulWidget {
  const GroceryHomePage({super.key});

  @override
  State<GroceryHomePage> createState() => _GroceryHomePageState();
}

class _GroceryHomePageState extends State<GroceryHomePage> {
  List<GroceryItem> _items = [];
  Map<String, int> _frequency = {};
  List<String> _suggestions = [];

  final TextEditingController _controller = TextEditingController();
  final StorageService _storage = StorageService();
  final SuggestionService _suggestionService = SuggestionService();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await _storage.loadData();
    setState(() {
      _items = data.items;
      _frequency = data.frequency;
    });
  }

  Future<void> _saveData() => _storage.saveData(_items, _frequency);

  void _onSearchChanged(String value) {
    setState(() {
      _suggestions = _suggestionService.getSuggestions(value, _frequency);
    });
  }

  void _addItem(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;
    setState(() {
      _items.add(GroceryItem(name: trimmed));
      _frequency[trimmed] = (_frequency[trimmed] ?? 0) + 1;
      _controller.clear();
      _suggestions = [];
    });
    _saveData();
  }

  void _toggleItem(String name) {
    setState(() {
      final item = _items.firstWhere((e) => e.name == name);
      item.isChecked = !item.isChecked;
    });
    _saveData();
  }

  void _deleteItem(String name) {
    setState(() => _items.removeWhere((e) => e.name == name));
    _saveData();
  }

  void _clearChecked() {
    setState(() => _items.removeWhere((item) => item.isChecked));
    _saveData();
  }

  @override
  Widget build(BuildContext context) {
    final unchecked = _items.where((e) => !e.isChecked).toList();
    final checked = _items.where((e) => e.isChecked).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        title: const Text('🛒  Smart Grocery',
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          if (checked.isNotEmpty)
            TextButton.icon(
              onPressed: _clearChecked,
              icon: const Icon(Icons.delete_sweep, color: Colors.white70),
              label: const Text('Clear done',
                  style: TextStyle(color: Colors.white70)),
            ),
        ],
      ),
      body: Column(
        children: [
          
          AddItemBar(
            controller: _controller,
            suggestions: _suggestions,
            onChanged: _onSearchChanged,
            onSubmitted: _addItem,
            onAddPressed: () => _addItem(_controller.text),
          ),

         
          Expanded(
            child: _items.isEmpty
                ? const EmptyListPlaceholder()
                : ListView(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    children: [
                      ...unchecked.map((item) {
                        return GroceryItemTile(
                          item: item,
                          index: _items.indexOf(item),
                          frequency: _frequency[item.name] ?? 0,
                          onToggle: () => _toggleItem(item.name),
                          onDismiss: () => _deleteItem(item.name),
                        );
                      }),
                      if (checked.isNotEmpty) ...[
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Row(children: [
                            Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text('Done',
                                  style: TextStyle(color: Colors.grey)),
                            ),
                            Expanded(child: Divider()),
                          ]),
                        ),
                        ...checked.map((item) {
                          return GroceryItemTile(
                            item: item,
                            index: _items.indexOf(item),
                            frequency: _frequency[item.name] ?? 0,
                            onToggle: () => _toggleItem(item.name),
                            onDismiss: () => _deleteItem(item.name),
                          );
                        }),
                      ],
                    ],
                  ),
          ),

        
          if (_items.isNotEmpty)
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${unchecked.length} item${unchecked.length != 1 ? 's' : ''} left',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Text(
                    '${checked.length} done',
                    style: const TextStyle(
                        color: Color(0xFF2E7D32),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}