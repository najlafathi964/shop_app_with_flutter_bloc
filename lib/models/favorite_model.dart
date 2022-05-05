class FavoriteModel{

  bool? status ;
  Data? data ;
  FavoriteModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;

  }

  }
  class Data {
  int? current_page ;
  List<FavDataModel> data = [];
  String? first_page_url;
  int? from ;
  int? last_page ;
  String? last_page_url ;
  String? path ;
  int? per_page ;
  int? to ;
  int? total ;
  Data.fromJson(Map<String,dynamic> json){
    current_page = json['current_page'];
    json['data'].forEach((element){
      data.add(FavDataModel?.fromJson(element)) ;
    }) ;
    first_page_url = json['first_page_url'];
    from = json['from'];
    last_page = json['last_page'];
    last_page_url = json['last_page_url'];
    path = json['path'];
    per_page = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  }
  class FavDataModel {
  int? id ;
  Product? product ;

  FavDataModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;



  }
  }

  class Product {
  int? id ;
  dynamic price;
  dynamic old_price ;
  dynamic discount;
  String? image;
  String? name;
  String? description ;

  Product.fromJson(Map<String,dynamic> json){
    id = json['id'] ;
    price = json['price'] ;
    old_price = json['old_price'] ;
    discount = json['discount'] ;
    image = json['image'] ;
    name = json['name'] ;
    description = json['description'] ;

  }
  }

