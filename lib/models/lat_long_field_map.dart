import 'dart:convert';

List<GoogleLatLongField> googleLatLongFieldFromJson(String str) => List<GoogleLatLongField>.from(json.decode(str).map((x) => GoogleLatLongField.fromJson(x)));

String googleLatLongFieldToJson(List<GoogleLatLongField> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GoogleLatLongField {
  GoogleLatLongField({
   required this.lat,
   required this.lng,

  });

  String lat;
  String lng;

  factory GoogleLatLongField.fromJson(Map<String, dynamic> json) => GoogleLatLongField(
    lat: json["lat"] ?? "24.86372859",
    lng: json["lng"] ?? "67.06049266",
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}
/*

class SubArea {
  SubArea({
   required this.name,
   required this.cordinates,
  });

  Name name;
  String cordinates;

  factory SubArea.fromJson(Map<String, dynamic> json) => SubArea(
    name: nameValues.map[json["name"]],
    cordinates: json["cordinates"],
  );

  Map<String, dynamic> toJson() => {
    "name": nameValues.reverse[name],
    "cordinates": cordinates,
  };
}

enum Name { BLOCK2, LRK_SUBAREA, NWB_SUBAREA }

final nameValues = EnumValues({
  "block2": Name.BLOCK2,
  "lrk subarea": Name.LRK_SUBAREA,
  "nwb subarea": Name.NWB_SUBAREA
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
*/
