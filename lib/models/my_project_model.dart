import 'package:flutter/material.dart';

class Project {
  int? id;
  String? projectName;
  String? projectDescription;
  int? createdBy;
  String? startingDate;
  String? endingDate;
  int? sampleQuotaAllocation;
  String? isPublish;
  String? projectCode;
  String? clientName;
  String? studyType;
  bool? isContinous;
  String? region;
  String? combinations;
  bool? autoProductSelection;
  bool? rotation;
  //String? qAParameters;
  int? qAThreshold;
  String? projectLogo;
  String? regionsGroupAssigmentDate;
  int? projectQAPercentage;
  int? batchPassingPercentage;
  int? sampleGenerationPercentage;
  bool? isAutoSave;
  String? createdAt;
  String? updatedAt;
  int? projectTypeId;
  int? companyId;
  int? regionsGroupingId;
  int? projectClassificationTypeId;
  List<Users>? users;
  String? projectType;
  String? projectClassificationType;
  String? totalAchivement;
  List<ProjectSettings>? projectSettings;
  String? percent;
  double? indicatorProgress;
  String? fieldStartDate;
  String? fieldEndDate;
  String? wave;
  MaterialColor? color;
  int? waveCount;

  Project(
      {this.id,
      this.projectName,
      this.projectDescription,
      this.createdBy,
      this.startingDate,
      this.endingDate,
      this.sampleQuotaAllocation,
      this.isPublish,
      this.projectCode,
      this.clientName,
      this.studyType,
      this.isContinous,
      this.region,
      this.combinations,
      this.autoProductSelection,
      this.rotation,
      // this.qAParameters,
      this.qAThreshold,
      this.projectLogo,
      this.regionsGroupAssigmentDate,
      this.projectQAPercentage,
      this.batchPassingPercentage,
      this.sampleGenerationPercentage,
      this.isAutoSave,
      this.createdAt,
      this.updatedAt,
      this.projectTypeId,
      this.companyId,
      this.regionsGroupingId,
      this.projectClassificationTypeId,
      this.users,
      this.projectType,
      this.projectClassificationType,
      this.totalAchivement,
      this.projectSettings,
      this.percent,
      this.indicatorProgress,
      this.fieldStartDate,
      this.fieldEndDate,
      this.color,
      this.wave,
      this.waveCount});

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectName = json['projectName'];
    projectDescription = json['projectDescription'];
    createdBy = json['createdBy'];
    startingDate = json['startingDate'];
    endingDate = json['endingDate'];
    sampleQuotaAllocation = json['sampleQuotaAllocation'];
    isPublish = json['isPublish'];
    projectCode = json['projectCode'];
    clientName = json['clientName'];
    studyType = json['studyType'];
    isContinous = json['isContinous'];
    region = json['region'];
    combinations = json['combinations'];
    autoProductSelection = json['autoProductSelection'];
    rotation = json['rotation'];
    //  qAParameters = json['QAParameters'];
    qAThreshold = json['QAThreshold'];
    projectLogo = json['projectLogo'];
    regionsGroupAssigmentDate = json['regionsGroupAssigmentDate'];
    projectQAPercentage = json['projectQAPercentage'];
    batchPassingPercentage = json['batchPassingPercentage'];
    sampleGenerationPercentage = json['sampleGenerationPercentage'];
    isAutoSave = json['isAutoSave'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    projectTypeId = json['projectTypeId'];
    companyId = json['companyId'];
    regionsGroupingId = json['regionsGroupingId'];
    projectClassificationTypeId = json['projectClassificationTypeId'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
    projectType = json['projectType'];
    projectClassificationType = json['projectClassificationType'];
    if (json['projectSettings'] != null) {
      projectSettings = <ProjectSettings>[];
      json['projectSettings'].forEach((v) {
        projectSettings!.add(new ProjectSettings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['projectName'] = this.projectName;
    data['projectDescription'] = this.projectDescription;
    data['createdBy'] = this.createdBy;
    data['startingDate'] = this.startingDate;
    data['endingDate'] = this.endingDate;
    data['sampleQuotaAllocation'] = this.sampleQuotaAllocation;
    data['isPublish'] = this.isPublish;
    data['projectCode'] = this.projectCode;
    data['clientName'] = this.clientName;
    data['studyType'] = this.studyType;
    data['isContinous'] = this.isContinous;
    data['region'] = this.region;
    data['combinations'] = this.combinations;
    data['autoProductSelection'] = this.autoProductSelection;
    data['rotation'] = this.rotation;
    //  data['QAParameters'] = this.qAParameters;
    data['QAThreshold'] = this.qAThreshold;
    data['projectLogo'] = this.projectLogo;
    data['regionsGroupAssigmentDate'] = this.regionsGroupAssigmentDate;
    data['projectQAPercentage'] = this.projectQAPercentage;
    data['batchPassingPercentage'] = this.batchPassingPercentage;
    data['sampleGenerationPercentage'] = this.sampleGenerationPercentage;
    data['isAutoSave'] = this.isAutoSave;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['projectTypeId'] = this.projectTypeId;
    data['companyId'] = this.companyId;
    data['regionsGroupingId'] = this.regionsGroupingId;
    data['projectClassificationTypeId'] = this.projectClassificationTypeId;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    data['projectType'] = this.projectType;
    data['projectClassificationType'] = this.projectClassificationType;
    if (this.projectSettings != null) {
      data['projectSettings'] =
          this.projectSettings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  String? incharge;

  Users({this.incharge});

  Users.fromJson(Map<String, dynamic> json) {
    incharge = json['incharge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['incharge'] = this.incharge;
    return data;
  }
}

class ProjectSettings {
  String ? quotaStatus;
  String ? quotaName;

  ProjectSettings({this.quotaStatus,this.quotaName});

  ProjectSettings.fromJson(Map<String, dynamic> json) {
    quotaStatus = json['quotaStatus'];
    quotaName = json['quotaName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quotaStatus'] = this.quotaStatus;
    data['quotaName'] = this.quotaName;
    return data;
  }
}
