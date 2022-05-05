class HomeModel {
  bool? status ;
  //String message ; \\لانها دايما null بنكتبهاش
  HomeDataModel? data ;
  HomeModel.fromJson(Map<String,dynamic> json){
    status = json['status'] ;
    data = json['data'] != null ? HomeDataModel.fromJson(json['data']) : null ;

  }

}

class HomeDataModel {

  List<BannerModel>? banners =[];
  List<ProductModel>? products =[];

  HomeDataModel.fromJson(Map<String,dynamic> json){
     json['banners'].forEach((element){
       banners!.add(BannerModel.fromJson(element));
     });
     json['products'].forEach((element){
       products!.add(ProductModel.fromJson(element));
     });
  }

}

class BannerModel {
  int?  id ;
  String? image ;
  BannerModel.fromJson(Map<String,dynamic>json){
    id = json['id'] ;
    image =json['image'];
  }
}

class ProductModel {

  int? id ;
  dynamic price ;
  dynamic old_price ;
  dynamic discount ;
  String? image ;
  String? name ;
  String? description ;
  List<String>? images =[] ;
  bool? in_favorites ;
  bool? in_cart ;

ProductModel.fromJson(Map<String,dynamic>json){
  id =json['id'] ;
  price =json['price'] ;
  old_price =json['old_price'] ;
  discount =json['discount'] ;
  json['images'].forEach((element){
    images!.add(element);
  });
  name =json['name'] ;
  description =json['description'] ;
  image =json['image'] ;
  in_favorites =json['in_favorites'] ;
  in_cart =json['in_cart'] ;


  }
}