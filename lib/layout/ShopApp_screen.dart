import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Shared/components/components.dart';
import 'package:shop_app/Shared/components/constants.dart';
import 'package:shop_app/layout/shop_cubit/ShopCubit.dart';
import 'package:shop_app/layout/shop_cubit/ShopStates.dart';
import 'package:shop_app/modules/search_screen/Search_screen.dart';

class ShopApp_Home_screen extends StatelessWidget {
   ShopApp_Home_screen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
  ShopCubit cubit=ShopCubit.get(context);
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state){} ,
      builder:(context,state)=> Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Wave'),
        actions: [
          IconButton(onPressed: (){
            Navigatorbuilder(context, SearchScreen());
          }, icon: Icon(Icons.search))
        ],
      ),

       body: cubit.Screen[current_Index1],
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(icon:Icon(Icons.home),label: 'Home' ),
          BottomNavigationBarItem(icon:Icon(Icons.apps),label: 'Categories' ),
          BottomNavigationBarItem(icon:Icon(Icons.favorite),label: 'favorite' ),
          BottomNavigationBarItem(icon:Icon(Icons.settings),label: 'settings' ),
        ],
        currentIndex: current_Index1,
        onTap: (index){
            cubit.ChangeNavBarIndex(index);

        },
          unselectedItemColor: Colors.blue,
          selectedItemColor: Colors.black,
          backgroundColor: Colors.orange[400],
        ),

      ),
    );
  }
}
