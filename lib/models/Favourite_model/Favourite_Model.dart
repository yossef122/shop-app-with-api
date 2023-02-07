class ChangeFavourite_Model {
  late bool status;
  late String message;
  // late FavouriteDataModel DataFavModel;


  ChangeFavourite_Model.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
    // DataFavModel=FavouriteDataModel.fromJson(json['data']);
  }
}

// class FavouriteDataModel{
//   late int id;
//   List<FavouriteDataproduct>products =[];
//   FavouriteDataModel.fromJson(Map<String,dynamic>json){
//     id=json['id'];
//     json['products'].forEach((element) {
//       products.add(FavouriteDataproduct.fromJson(element));
//     });
//   }
// }
//
//
// class FavouriteDataproduct{
//
// late  int id;
//   dynamic price;
//   dynamic old_price;
//   dynamic discount;
//   dynamic name;
// late String image;
//
//
//   FavouriteDataproduct.fromJson(Map<String,dynamic>json){
//     id=json['id'];
//     price=json['price'];
//     old_price=json['old_price'];
//     discount=json['discount'];
//     name=json['name'];
//     image=json['image'];
//   }
// }