class PasswordModel{
  bool? status ;
  String? message ;
  PassDataModel? data ;

  PasswordModel.fromJson(Map<String, dynamic> json){
    status = json['status'] ;
    message = json['message'] ;
    data = json['data'] != null ? PassDataModel.fromJson(json['data']) : null ;

  }
}

class PassDataModel {
  String? email ;
  PassDataModel.fromJson(Map<String,dynamic> json){
    email = json['email'] ;
  }
}




class VerfiyCode {
  bool? status ;
  String? message ;
  CodeModel? data ;
  VerfiyCode.fromJson(Map<String, dynamic> json){
    status = json['status'] ;
    message = json['message'] ;
    data = json['data'] != null ? CodeModel.fromJson(json['data']) : null ;

  }
  
}

class CodeModel {
  int? id ;
  String? name ;
  String? email ;
  String? phone ;
  String? image ;
  int? points ;

  CodeModel.fromJson(Map<String,dynamic> json){
    id = json['id'] ;
    name = json['name'] ;
    email = json['email'] ;
    phone = json['phone'] ;
    image = json['image'] ;
    points = json['points'] ;

  }

}