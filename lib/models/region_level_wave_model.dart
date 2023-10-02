class RegionLevelWaveManagementModel {
  int? id;
  String? unMerge;
  String? merge;
  List<RegionRefData>? regionRefData;
  String? createdAt;
  String? updatedAt;
  int? projectId;
  int? regionsGroupingId;

  RegionLevelWaveManagementModel(
      {this.id,
        this.unMerge,
        this.merge,
        this.regionRefData,
        this.createdAt,
        this.updatedAt,
        this.projectId,
        this.regionsGroupingId});

  RegionLevelWaveManagementModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unMerge = json['unMerge'];
    merge = json['merge'];
    if (json['regionRefData'] != null) {
      regionRefData = <RegionRefData>[];
      json['regionRefData'].forEach((v) {
        regionRefData!.add(new RegionRefData.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    projectId = json['projectId'];
    regionsGroupingId = json['regionsGroupingId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['unMerge'] = this.unMerge;
    data['merge'] = this.merge;
    if (this.regionRefData != null) {
      data['regionRefData'] =
          this.regionRefData!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['projectId'] = this.projectId;
    data['regionsGroupingId'] = this.regionsGroupingId;
    return data;
  }
}

class RegionRefData {
  int? id;
  String? name;
  bool? checked;
  int? levelId;
  String? levelName;
  List<Choices>? choices;

  RegionRefData(
      {this.id,
        this.name,
        this.checked,
        this.levelId,
        this.levelName,
        this.choices});

  RegionRefData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    checked = json['checked'];
    levelId = json['levelId'];
    levelName = json['levelName'];
    if (json['choices'] != null) {
      choices = <Choices>[];
      json['choices'].forEach((v) {
        choices!.add(new Choices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['checked'] = this.checked;
    data['levelId'] = this.levelId;
    data['levelName'] = this.levelName;
    if (this.choices != null) {
      data['choices'] = this.choices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Choices {
  int? id;
  String? name;
  bool? checked;

  Choices({this.id, this.name, this.checked});

  Choices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    checked = json['checked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['checked'] = this.checked;
    return data;
  }
}