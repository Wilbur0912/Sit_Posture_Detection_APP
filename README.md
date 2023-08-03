# Sit_Posture_Detection_APP
### APP主要頁面
![image](https://github.com/Wilbur0912/Sit_Posture_Detection_APP/assets/89004015/ee9deae8-6b0b-49e8-bcf9-5c3f220ee52c)

### 如果要增加頁面，哪些code需要改?

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
