class UserModel {
  bool? status ;
  String? message ;
  UserDataModel? data ;

  UserModel.fromJson(Map<String, dynamic> json){
    status = json['status'] ;
    message = json['message'] ;
    data = json['data'] != null ? UserDataModel.fromJson(json['data']) : null ;

  }
}

class UserDataModel {
  int? id ;
  String? name ;
  String? email ;
  String? phone ;
  String? image ;
  dynamic points ;
  dynamic credit ;
  String? token ;

  UserDataModel.fromJson(Map<String,dynamic> json) {

    id = json['id'] ;
    name = json['name'] ;
    email = json['email'] ;
    phone = json['phone'] ;
    image = json['image'] ;
    points = json['points'] ;
    credit = json['credit'] ;
    token = json['token'] ;


  }
}