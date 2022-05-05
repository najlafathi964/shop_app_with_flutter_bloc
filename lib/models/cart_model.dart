class CartModel {
  bool? status;

  String? message;

  CartDataModel? data;

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? CartDataModel.fromJson(json['data']) : null;
  }
}

class CartDataModel {
  List<CartItemModel>? cart_items = [];

  dynamic sub_total;

  dynamic total;

  CartDataModel.fromJson(Map<String, dynamic> json) {
    json['cart_items'].forEach((element) {
      cart_items!.add(CartItemModel.fromJson(element));
    });
    sub_total = json['sub_total'];
    total = json['total'];
  }
}

class CartItemModel {
  int? id;

  int? quantity;

  Product? product;

  CartItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }
}

class Product {
  int? id;

  dynamic price;

  dynamic old_price;

  dynamic discount;

  String? image;

  String? name;

  String? description;

  List<String>? images = [];

  bool? in_favorites;

  bool? in_cart;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    json['images'].forEach((element) {
      images!.add(element);
    });
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
  }
}
