class HomeModel{
   bool? status;
   Datamodel? data;
  HomeModel.fromJson(Map <String,dynamic>json){
    status=json['status'];
    data=Datamodel.fromJson(json['data']);
  }
}

class  Datamodel{
   List<DataBanners>  banners=[];
   List<Dataproducts> products=[];

  Datamodel.fromJson(Map<String,dynamic>json){
    json['banners'].forEach((element) {
      banners.add ( DataBanners.fromJson(element) );
    });

    json['products'].forEach((element) {
      products.add(Dataproducts.fromJson(element));
    });
  }
}

class DataBanners{
   int? id;
   String? image;
  DataBanners.fromJson(Map<String,dynamic>json){
    id= json['id'];
    image= json['image'];
  }
}

class Dataproducts{
  late int id;
   dynamic? price;
   dynamic? old_price;
   dynamic? discount;
   String? name;
   String? image;
  late bool in_favorites;
   bool? in_cart;
  Dataproducts.fromJson(Map<String,dynamic>json){
    id= json['id'];
    price= json['price'];
    old_price= json['old_price'];
    discount= json['discount'];
    name= json['name'];
    image= json['image'];
    in_favorites= json['in_favorites'];
    in_cart= json['in_cart'];
  }
}