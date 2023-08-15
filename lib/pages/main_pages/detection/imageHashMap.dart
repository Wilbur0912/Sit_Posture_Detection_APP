String callPostureImage(String key) {
  // 函式內容
  Map<String, String> imageMap = {
    '翹左腳': 'assets/images/翹左腳.jpg',
    '翹右腳': 'assets/images/翹右腳.jpg',
    '人面獅身坐姿': 'assets/images/人面獅身坐姿.jpg',
    '三分之一坐姿': 'assets/images/三分之一坐姿.jpg',
    '上半身右傾': 'assets/images/上半身右傾.jpg',
    '上半身左傾': 'assets/images/上半身左傾.jpg',
    '半身駝背': 'assets/images/半身駝背.jpg',
    '半躺半坐': 'assets/images/半躺半坐.jpg',
    '坐姿端正': 'assets/images/坐姿端正.jpg',
  };
  if (imageMap.containsKey(key)) {
    return imageMap[key]!;
  } else {
    return ''; // 或返回一個預設的圖片路徑
  }
}