class PostDeleteFavModel{
  String? status;
  String? message;
  PostDeleteFavModel({this.status,this.message});
  PostDeleteFavModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
  }
}
class FavModel{
  String? status;
  List<FavProduct>? favProducts;

  FavModel({this.favProducts,this.status});

  FavModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['favoriteProducts'] != null) {
      favProducts = <FavProduct>[];
      json['favoriteProducts'].forEach((v) {
        favProducts!.add(FavProduct.fromJson(v));
      });
    }
  }
}


class FavProduct {
  String? sId;
  String? status;
  String? category;
  String? name;
  dynamic price;
  String? description;
  String? image;
  String? company;
  dynamic countInStock;
  List<String>? images;
  dynamic iV;

  FavProduct(
      {this.sId,
        this.status,
        this.category,
        this.name,
        this.price,
        this.description,
        this.image,
        this.company,
        this.countInStock,
        this.iV,
      });

  FavProduct.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    status = json['status'];
    category = json['category'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    image = json['image'];
    images = json['images'].cast<String>();
    company = json['company'];
    countInStock = json['countInStock'];
    iV = json['__v'];
  }

}