class ResponseModel {
  String? token;
  int? status;

  ResponseModel({this.token, this.status});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['status'] = this.status;
    return data;
  }
}



/*
class ResponseModel {
  String? token;
  List<Projects>? projects;
  int? status;

  ResponseModel({required this.token, required this.projects, required this.status});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    if (json['projects'] != null) {
      projects = <Projects>[];
      json['projects'].forEach((v) {
        projects!.add(new Projects.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.projects != null) {
      data['projects'] = this.projects!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Projects {
  int? id;
  String? projectName;
  String? projectDescription;
  String? startingDate;
  String? endingDate;
  String? createdAt;
  String? updatedAt;
  int? projectTypeId;
  String? studyType;
  int? createdBy;
  int? projectClassificationTypeId;
  ProjectClassificationType? projectClassificationType;
  List<Users>? users;

  Projects(
      {this.id,
        this.projectName,
        this.projectDescription,
        this.startingDate,
        this.endingDate,
        this.createdAt,
        this.updatedAt,
        this.projectTypeId,
        this.studyType,
        this.createdBy,
        this.projectClassificationTypeId,
        this.projectClassificationType,
        this.users});

  Projects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectName = json['projectName'];
    projectDescription = json['projectDescription'];
    startingDate = json['startingDate'];
    endingDate = json['endingDate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    projectTypeId = json['projectTypeId'];
    studyType = json['studyType'];
    createdBy = json['createdBy'];
    projectClassificationTypeId = json['projectClassificationTypeId'];
    projectClassificationType = json['projectClassificationType'] != null
        ? new ProjectClassificationType.fromJson(
        json['projectClassificationType'])
        : null;
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['projectName'] = this.projectName;
    data['projectDescription'] = this.projectDescription;
    data['startingDate'] = this.startingDate;
    data['endingDate'] = this.endingDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['projectTypeId'] = this.projectTypeId;
    data['studyType'] = this.studyType;
    data['createdBy'] = this.createdBy;
    data['projectClassificationTypeId'] = this.projectClassificationTypeId;
    if (this.projectClassificationType != null) {
      data['projectClassificationType'] =
          this.projectClassificationType!.toJson();
    }
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProjectClassificationType {
  String? name;

  ProjectClassificationType({this.name});

  ProjectClassificationType.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class Users {
  String? userName;

  Users({this.userName});

  Users.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    return data;
  }
}*/
