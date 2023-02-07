  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:shop_app/Shared/bloc_observe/bloc_observe.dart';
  import 'package:shop_app/Shared/components/constants.dart';
  import 'package:shop_app/Shared/cubit/cubit/cubit.dart';
  import 'package:shop_app/Shared/network/local/cachehelper.dart';
  import 'package:shop_app/Shared/network/remotly/diohelper.dart';
  import 'package:shop_app/Shared/styles/themes.dart';
  import 'package:shop_app/layout/ShopApp_screen.dart';
  import 'package:shop_app/layout/shop_cubit/ShopCubit.dart';
  import 'package:shop_app/layout/shop_cubit/ShopStates.dart';
  import 'package:shop_app/modules/Onboarding/onBorading_Screen.dart';

  import 'package:shop_app/modules/login/login_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  diohelper.init();

  await cashehelper.init();

  var Onboareding = cashehelper.Getdata(key:'Isboarding');
  print(Onboareding);

  Widget start ;

  if(Onboareding!=null)
    {
  token =cashehelper.Getdata(key: 'token' );
    print(token);
      if(token!=null)
        start =ShopApp_Home_screen();
      else
         start =MyLoginScreen();
    }
  else {
    start = onBorading_Screen();
  }
  runApp(MyApp(/*Isdark: cashehelper.getdata(key:"isDark"),*/ Start: start,/*onBoarding:Onboaredingcashehelper.Getdata(key:"Isboarding")*/));

      // Isdark:cashehelper.getdata(key: 'Isdark')))
}

class MyApp extends StatelessWidget {
// final bool? Isdark;
      final Widget Start ;

      const MyApp({super.key/*, required this.Isdark*/,  required this.Start});

    @override
    Widget build(BuildContext context) {
      return
        MultiBlocProvider(
          providers: [
            // BlocProvider(
            // create: (BuildContext context) =>AppCubit()..getbusiness()..getsports()..getscience()),
            BlocProvider(
                create: (BuildContext context)=>AppCubit()),
            BlocProvider(
                create: (BuildContext context)=>ShopCubit()..getDataHome()..getcategoriesHome()/*..getfavouritEHome()*/..getFavouriteData()..getUserData()),
          ],
          // ..changeMode(fromchared:isdark)..getbusiness()..getscience()..getsports()
        child: BlocConsumer<ShopCubit,ShopStates>(
          listener: (BuildContext context, state) {},
    builder: (BuildContext context, Object? state) =>
      MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lighttheme,
              darkTheme: darktheme,
              themeMode:/*AppCubit.get(context).isdark ? ThemeMode.dark :*/ ThemeMode.light,
              home:/*onBoarding? onBorading_Screen():MyLoginScreen()*/Start,
      //     ),
        ),
       ),
    );
  }
}
