# Sit_Posture_Detection_APP
### APP主要頁面
![image](https://github.com/Wilbur0912/Sit_Posture_Detection_APP/assets/89004015/c8c88737-edc1-407b-8dae-bd17cb06bfc5)

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



### 想調用 userprofile 該如何實踐
1. 在頁面 build 引入 userProfileProvider
```
  final userProfileProvider =
   context.read<UserProfileProvider>();
```
2. 調用 userProfileProvider 中 userprofile 的 屬性
```
ex: userProfileProvider.userProfile?.token
```

