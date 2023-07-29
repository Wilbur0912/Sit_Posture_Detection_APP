# APPP3

## 如果要增加頁面，那些code需要改?

1. flutterflow/nav/nav.dart

```
    FFRoute(
      name: 'WeightEntryCopy',
      path: 'weightEntryCopy',
      builder: (context, params) => WeightEntryCopyWidget(),
    )
```

2. index.dart
```
  export '/pages/onboarding/weight_entry_copy/weight_entry_copy_widget.dart'
      show WeightEntryCopyWidget;
```
