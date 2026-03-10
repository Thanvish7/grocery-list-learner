class GroceryItem {
  String name;
  bool isChecked;

  GroceryItem({required this.name, this.isChecked = false});

  Map<String, dynamic> toJson() => {'name': name, 'isChecked': isChecked};

  factory GroceryItem.fromJson(Map<String, dynamic> json) =>
      GroceryItem(name: json['name'], isChecked: json['isChecked'] ?? false);
}
