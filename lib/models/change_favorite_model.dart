class ChangeFavoriteModel {
  late bool status ;
  String? message ;

  ChangeFavoriteModel.fromJson(Map<String , dynamic> json ){
    status = json['status'] ;
    message = json['message'] ;

  }
}