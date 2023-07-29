# Sit_Posture_Detection_APP

### If you want to add pages without flutterflow
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

