# Smart Grocery

A beginner-friendly Flutter grocery list app that learns your frequently added items and suggests them automatically.

---

## Features

- **Add items** — type and press enter or tap the + button
- **Smart suggestions** — items you've added 2+ times appear as chips while you type
- **Check off items** — tap the checkbox while shopping
- **Swipe to delete** — swipe left on any item to remove it
- **Star badge** — appears on items you've bought 3+ times
- **Clear done** — removes all checked items at once
- **Persistent storage** — your list survives app restarts

---

## Getting Started

### 1. Create a new Flutter project
```bash
flutter create grocery_app
cd grocery_app
```

### 2. Add the dependency
In `pubspec.yaml`, add under `dependencies`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.2.2
```

### 3. Copy the source files
Replace the contents of your `lib/` folder with the files from this project.

### 4. Install packages & run
```bash
flutter pub get
flutter run
```

---

## Project Structure

```
lib/
├── main.dart                        # App entry point & theme
├── models/
│   └── grocery_item.dart            # GroceryItem data class
├── services/
│   ├── storage_service.dart         # Load/save data with SharedPreferences
│   └── suggestion_service.dart      # Smart suggestion logic
├── screens/
│   └── home_screen.dart             # Main screen, holds all state
└── widgets/
    ├── add_item_bar.dart             # Input field + suggestion chips
    ├── grocery_item_tile.dart        # Single list item row
    └── empty_list_placeholder.dart  # Shown when list is empty
```

---

## How the Smart Suggestions Work

Every time you add an item, its name is saved in a frequency map:

```dart
Map<String, int> frequency = {
  "milk": 5,
  "eggs": 4,
  "bread": 3,
}
```

When you start typing, items with a count of **2 or more** that match your input are shown as suggestion chips. The most frequent ones appear first. No ML needed — just a simple counter!

---

## Dependencies

| Package | Version | Purpose |
|---|---|---|
| [shared_preferences](https://pub.dev/packages/shared_preferences) | ^2.2.2 | Save list data locally on device |
