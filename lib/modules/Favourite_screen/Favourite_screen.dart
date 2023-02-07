import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Shared/components/constants.dart';
import 'package:shop_app/layout/shop_cubit/ShopCubit.dart';
import 'package:shop_app/layout/shop_cubit/ShopStates.dart';
import 'package:shop_app/models/Favourite_model/new_fav_Data.dart';
// import 'package:shop_app/models/Favourite_model/fav.dart';


class FavouriteScreen extends StatelessWidget {
   FavouriteScreen ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state){} ,
      builder:(context,state) {
  var cubit=ShopCubit.get(context);
        return Scaffold(
          body:state is! ShopGettingfavouriteLoadingState/* is ShopChangeFavouriteSuccessState*/ ? ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder:(cotext,index)=> BuildFavItems (cubit.favouritesModel!.data!.data[index].product,context)/*:Container(
                height: 200,
              ) */,
              separatorBuilder: (cotext,index)=>Container(
                color: Colors.grey,
                height: 1,
                width: double.infinity,
              ),
              itemCount:  cubit.favouritesModel!.data!.data.length) :
          const Center(
              child: CircularProgressIndicator()
          )
      );
      },
    );
  }
  Widget BuildFavItems(Product? model,context)=>Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image(
              image: NetworkImage(
                '${model!.image}',
              ),
              height: 130,
              width: 130,
              fit: BoxFit.contain,
            ),
            if (model.discount != 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                // height: 20,
                color: Colors.red,
                child: const Text(
                  'Discound',
                  style:  TextStyle(color: Colors.white, fontSize: 12),
                ),
              )
          ],
        ),
        Expanded(
          child: Container(
            height: 120,
            width: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.name}',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold, height: 1.4),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.price}',
                      style: TextStyle(
                          color: defaultcolor, fontSize: 14, height: 1.4),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice}',
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            height: 1.4,
                            decoration: TextDecoration.lineThrough),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const Spacer(),

                    CircleAvatar(
                      radius: 14,
                      backgroundColor:
                       ShopCubit.get(context).favourite[model.id]==true? Colors.red :Colors.white,
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            ShopCubit.get(context).ChangeFavourite(model.id);
                          },
                          icon: Icon(
                              Icons.favorite_border,
                              size: 20,
                              color:ShopCubit.get(context).favourite[model.id]==true ? Colors.white : Colors.grey
                          )

                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}
