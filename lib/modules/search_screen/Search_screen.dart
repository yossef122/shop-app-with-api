import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Shared/components/components.dart';
import 'package:shop_app/Shared/components/constants.dart';
import 'package:shop_app/layout/shop_cubit/ShopCubit.dart';
import 'package:shop_app/modules/search_screen/cubit/Search_Cubit.dart';
import 'package:shop_app/modules/search_screen/cubit/Search_states.dart';

import '../../models/Search_model/search_model.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen ({Key? key}) : super(key: key);
  var formKey=GlobalKey<FormState>();
  var SearchControler=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>Search_Cubit(),
      child: BlocConsumer<Search_Cubit,Search_States>(
        listener: (context,state){},
       builder:(context,state){
          var cubit =Search_Cubit.get(context);
          return Scaffold(
            appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaulTextFormFied(
                          labelText: 'Search',
                          PrefixIcon: Icons.search,
                          controller: SearchControler,
                          keyboard: TextInputType.text,
                          ValidateFunction: (String? value){
                            if(value!.isEmpty){
                              return 'enter atext to search';
                            }
                            return null;
                          },
                          onsubmit: (String value){
                            Search_Cubit.get(context).SearchData(value);
                          }

                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if(state is SearchloadingState)
                        const LinearProgressIndicator(),
                      const SizedBox(
                        height: 20,
                      ),
                      if(state is SearchsucessState)
                        ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder:(cotext,index)=>
                            BuildItemsSearch (cubit.model!.data!.data![index],context,IS_OldPrice: false),
                            separatorBuilder: (cotext,index)=>Container(
                              color: Colors.grey,
                              height: 1,
                              width: double.infinity,
                            ),
                            itemCount:  cubit.model!.data!.data!.length),
                    ],
                  ),
                ),
              )
          );
       }
        
      ),
    );
  }
   Widget BuildItemsSearch(Product? model,context , {bool IS_OldPrice =true})=>Padding(
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
               height: 120,
               width: 120,
               fit: BoxFit.cover,
             ),
             if (model.discount != 0)
               Container(
                 padding: const EdgeInsets.symmetric(horizontal: 24),
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
                     if (model.discount != 0 &&IS_OldPrice)
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
