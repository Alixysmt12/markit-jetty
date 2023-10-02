class UserDecode {
  int? id;
  String? name;
  String? userName;
  String? roleGroup;
  int? companyId;
  int? iat;

  UserDecode(
      {this.id,
        this.name,
        this.userName,
        this.roleGroup,
        this.companyId,
        this.iat});

  UserDecode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userName = json['userName'];
    roleGroup = json['roleGroup'];
    companyId = json['companyId'];
    iat = json['iat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['userName'] = this.userName;
    data['roleGroup'] = this.roleGroup;
    data['companyId'] = this.companyId;
    data['iat'] = this.iat;
    return data;
  }
}