class categoriesModel{
   bool? status;
   CategorieDatamodel? data;
   categoriesModel.fromJson(Map <String,dynamic>json){
    status=json['status'];
    data=CategorieDatamodel.fromJson(json['data']);
  }
}

class CategorieDatamodel{
  int? current_page;
   List<DataCategorie>dataCategorie=[];

  CategorieDatamodel.fromJson(Map<String,dynamic>json){
    json['data'].forEach((element) {
      dataCategorie.add ( DataCategorie.fromJson(element) );
    });

    current_page= json['current_page'];
  }
}

class DataCategorie{
   int? id;
   String? name;
   String? image;
   DataCategorie.fromJson(Map<String,dynamic>json){
    id= json['id'];
    name= json['name'];
    image= json['image'];
  }
}



