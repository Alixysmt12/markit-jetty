class DiagnosticModel {
  int? id;
  String? activity;
  String? action;
  String? actionLabel;
  String? userName;
  String? status;
  StatusDescription? statusDescription;
  String? iPAddress;
  String? lat;
  String? lng;
  String? createdAt;
  String? updatedAt;
  int? projectId;

  DiagnosticModel(
      {this.id,
        this.activity,
        this.action,
        this.actionLabel,
        this.userName,
        this.status,
        this.statusDescription,
        this.iPAddress,
        this.lat,
        this.lng,
        this.createdAt,
        this.updatedAt,
        this.projectId});

  DiagnosticModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    activity = json['activity'];
    action = json['action'];
    actionLabel = json['actionLabel'];
    userName = json['userName'];
    status = json['status'];
    statusDescription = json['statusDescription'] != null
        ? new StatusDescription.fromJson(json['statusDescription'])
        : null;
    iPAddress = json['IPAddress'];
    lat = json['lat'];
    lng = json['lng'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    projectId = json['projectId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['activity'] = this.activity;
    data['action'] = this.action;
    data['actionLabel'] = this.actionLabel;
    data['userName'] = this.userName;
    data['status'] = this.status;
    if (this.statusDescription != null) {
      data['statusDescription'] = this.statusDescription!.toJson();
    }
    data['IPAddress'] = this.iPAddress;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['projectId'] = this.projectId;
    return data;
  }
}

class StatusDescription {
  Req? req;
  String? res;

  StatusDescription({this.req, this.res});

  StatusDescription.fromJson(Map<String, dynamic> json) {
    req = json['req'] != null ? new Req.fromJson(json['req']) : null;
    res = json['res'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.req != null) {
      data['req'] = this.req!.toJson();
    }
    data['res'] = this.res;
    return data;
  }
}

class Req {
  String? projectID;
  CurrentFieldData? currentFieldData;

  Req({this.projectID, this.currentFieldData});

  Req.fromJson(Map<String, dynamic> json) {
    projectID = json['projectID'];
    currentFieldData = json['currentFieldData'] != null
        ? new CurrentFieldData.fromJson(json['currentFieldData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['projectID'] = this.projectID;
    if (this.currentFieldData != null) {
      data['currentFieldData'] = this.currentFieldData!.toJson();
    }
    return data;
  }
}

class CurrentFieldData {
  bool? isPublish;

  CurrentFieldData({this.isPublish});

  CurrentFieldData.fromJson(Map<String, dynamic> json) {
    isPublish = json['isPublish'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isPublish'] = this.isPublish;
    return data;
  }
}