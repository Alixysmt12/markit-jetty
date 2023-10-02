import 'dart:convert';

List<HierarchyUser> hierarchyUserFromJson(String str) => List<HierarchyUser>.from(json.decode(str).map((x) => HierarchyUser.fromJson(x)));

String hierarchyUserToJson(List<HierarchyUser> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HierarchyUser {
  HierarchyUser({
    required this.userId,
    required this.name,
  });

  int userId;
  String name;

  factory HierarchyUser.fromJson(Map<String, dynamic> json) => HierarchyUser(
    userId: json["userId"],
    name: json["Name"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "Name": name,
  };
}
