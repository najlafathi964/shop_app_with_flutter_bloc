class UpdateCartModel{
  bool? status ;
  String? message ;
  UpdateDataModel? data ;
  UpdateCartModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UpdateDataModel.fromJson(json['data']) : null;

  }
}

class UpdateDataModel {
  UpCartModel? cart ;
  dynamic sub_total ;
  dynamic total ;
  UpdateDataModel.fromJson(Map<String,dynamic> json){
    sub_total = json['sub_total'];
    total = json['total'];
    cart = json['cart'] != null ? UpCartModel.fromJson(json['cart']) : null;

  }
}

class UpCartModel {
  int? id ;
  int? quantity ;
  Product? product ;

  UpCartModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    quantity = json['quantity'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;



  }
}

class Product {
  int? id ;
  dynamic price ;
  dynamic old_price ;
  dynamic discount ;
  String? image ;

  Product.fromJson(Map<String,dynamic> json){
    id = json['id'] ;
    price = json['price'] ;
    old_price = json['old_price'] ;
    discount = json['discount'] ;
    image = json['image'] ;

  }
}