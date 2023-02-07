import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Shared/components/components.dart';
import 'package:shop_app/Shared/components/constants.dart';
import 'package:shop_app/layout/shop_cubit/ShopCubit.dart';
import 'package:shop_app/layout/shop_cubit/ShopStates.dart';
import 'package:shop_app/models/Home_model/Home_model.dart';
import 'package:shop_app/models/categories_model/categories_model.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopChangeFavouriteSuccessState) {
          if (!state.model.status) {
            ShowToast(
                state: ToastColorState.error, message: state.model.message);
          }
        }
      },
      builder: (context, state) =>
          Scaffold(
              body: ShopCubit
                  .get(context)
                  .homemodel != null &&
                  ShopCubit
                      .get(context)
                      .categorie != null
                  ? HomeBuilder(ShopCubit
                  .get(context)
                  .homemodel,
                  ShopCubit
                      .get(context)
                      .categorie, context)
                  : Center(child: CircularProgressIndicator())),
    );
  }

  Widget HomeBuilder(HomeModel? model, categoriesModel? categoriesmodel,
      context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: model!.data!.banners
                    .map((e) =>
                    Image(
                      image: NetworkImage('${e.image}'),
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ))
                    .toList(),
                options: CarouselOptions(
                  height: 235,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  //هيفضل يلف حوالين نفسه
                  reverse: false,
                  // عشان ميتقلبش
                  autoPlay: true,
                  viewportFraction: 1,
                  autoPlayInterval: Duration(seconds: 4),
                  //هياخد وقت قد اي عقبال م يقلب
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                )),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Categories",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 120,
                    width: double.infinity,
                    child: ListView.separated(
                      // shrinkWrap: false,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            BuildCategoriesItems(
                                categoriesmodel!.data!.dataCategorie[index]),
                        separatorBuilder: (context, index) =>
                            Container(
                              width: 5,
                            ),
                        itemCount: categoriesmodel!.data!.dataCategorie.length),
                  ),
                  Text(
                    "New Products",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              color: Colors.grey,
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.9,
                //الطول مقسوم علي العرض
                children: List.generate(
                    model.data!.products.length,
                        (index) =>
                        HomeProductBuilder(
                            model.data!.products[index], context
                        )
                ),
              ),
            )
          ],
        ),
      ),
    );
// );
  }

  Widget BuildCategoriesItems(DataCategorie model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Image(
                image: NetworkImage('${model.image}'),
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
              Container(
                width: 100,
                color: Colors.black.withOpacity(.8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    '${model.name}',
                    maxLines: 1,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ],
      );

  Widget HomeProductBuilder(Dataproducts model, context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage(
                  '${model.image}',
                ),
                height: 250,
                width: double.infinity,
                // fit: BoxFit.cover,
              ),
              if (model.discount != 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  // height: 20,
                  color: Colors.red,
                  child: Text(
                    'Discound',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.name}',
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold, height: 1.4),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      style: TextStyle(
                          color: defaultcolor, fontSize: 14, height: 1.4),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.old_price.round()}',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            height: 1.4,
                            decoration: TextDecoration.lineThrough),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    Spacer(),
                    /*hopCubit.get(context).favourite[model.id] == null ||*/
                    // ShopCubit.get(context).favourite[model.id]==true  ?
                    CircleAvatar(
                      radius: 14,
                      backgroundColor:
                      ShopCubit
                          .get(context)
                          .favourite[model.id] == true ? Colors.red : Colors
                          .white,
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            ShopCubit.get(context).ChangeFavourite(model.id);
                          },
                          icon: Icon(
                              Icons.favorite_border,
                              size: 20,
                              color: ShopCubit
                                  .get(context)
                                  .favourite[model.id] == true
                                  ? Colors.white
                                  : Colors.grey
                          )

                      ),
                    )
                    //       :

                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
