import 'dart:convert';

List<SitRecord> SitRecordFromResponse(String body) {
  List<dynamic> jsonList = json.decode(body);
  return jsonList.map((jsonMap) => SitRecord.fromJson(jsonMap)).toList();
}

class SitRecord {
  int id;
  String position;
  DateTime time;
  int second;

  SitRecord(
      {required this.id,
        required this.position,
        required this.time,
        required this.second,
        });

  factory SitRecord.fromJson(Map<String, dynamic> json) => SitRecord(
      id: json["id"],
      position: json["position"],
      time: DateTime.parse(json["time"].toString().split("+").first),
      second: json["second"] != null ? int.tryParse(json["second"].toString()) ?? 0 : 0,
  );
}
