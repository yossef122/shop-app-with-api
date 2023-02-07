import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_cubit/ShopCubit.dart';
import 'package:shop_app/layout/shop_cubit/ShopStates.dart';
import 'package:shop_app/models/categories_model/categories_model.dart';

class CategorieScreen extends StatelessWidget {
  const CategorieScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state){} ,
      builder:(context,state)=> Scaffold(
        appBar: AppBar(),
        body: ListView.separated(
          physics: BouncingScrollPhysics(),
            itemBuilder:(cotext,index)=>buildCategorieItem (ShopCubit.get(context).categorie!.data!.dataCategorie[index]) ,
            separatorBuilder: (cotext,index)=>Container(
              color: Colors.grey,
              height: 1,
              width: double.infinity,
            ),
            itemCount:  ShopCubit.get(context).categorie!.data!.dataCategorie.length)
      ),
    );
  }
  Widget buildCategorieItem(DataCategorie model)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [

        Image(image: NetworkImage('${model.image}'),
          width: 80,
          height: 80,
          fit: BoxFit.cover,),
        SizedBox(
          width: 20,
        ),
        Text("${model.name}"),
        Spacer(),
        IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios))
      ],
    ),
  );
}
