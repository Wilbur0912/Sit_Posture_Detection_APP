import 'dart:convert';

List<SitRecord> SitRecordFromResponse(String body) {
  List<dynamic> jsonList = json.decode(body);
  return jsonList.map((jsonMap) => SitRecord.fromJson(jsonMap)).toList();
}

class SitRecord {
  int id;
  String position;
  DateTime time;
  int minutes;

  SitRecord(
      {required this.id,
        required this.position,
        required this.time,
        required this.minutes,
        });

  factory SitRecord.fromJson(Map<String, dynamic> json) => SitRecord(
      id: json["id"],
      position: json["position"],
      time: DateTime.parse(json["time"].toString().split("+").first),
      minutes: json["minutes"] != null ? int.tryParse(json["minutes"].toString()) ?? 0 : 0,
  );
}
