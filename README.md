# APPP3

A new Flutter project.

## Getting Started

FlutterFlow projects are built to run on the Flutter _stable_ release.

### Getting started continued:

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### If adding page without flutterflow
few codes of file need to be changed
1. nav.dart

ex:
```
FFRoute(
  name: 'HeightEntry',
  path: 'HeightEntry',
  builder: (context, params) => HeightEntryWidget(),
),
FFRoute( // if add weightEntryCopy page
  name: 'WeightEntryCopy',
  path: 'weightEntryCopy',
  builder: (context, params) => WeightEntryCopyWidget(),
)
```
2. index.dart
```
export '/pages/onboarding/height_entry/height_entry_widget.dart'
    show HeightEntryWidget;
export '/pages/onboarding/weight_entry_copy/weight_entry_copy_widget.dart' // if add weightEntryCopy page
    show WeightEntryCopyWidget;
```

