

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Shared/components/constants.dart';
import 'package:shop_app/Shared/cubit/cubit/states.dart';
import 'package:shop_app/Shared/network/local/cachehelper.dart';
import 'package:shop_app/Shared/network/remotly/diohelper.dart';

class AppCubit extends Cubit<appstates>{
  AppCubit():super(initialState());
 static AppCubit get(context)=>BlocProvider.of(context);

 void Bottomnavbarchange(int index){
   current_Index =index;
   if(current_Index==1)
      getsports();
   else if(index ==2)
     getscience();
   emit(Bottomnavbarchangestate());
 }
  List<dynamic> business =[];

  getbusiness(){
   emit(Newgetbussinessloadingstate());
   diohelper.get(
       path: 'v2/top-headlines',
       qurery: {
         'country':'us',
         'category':'business',
         'apiKey':'72288b3259c1493a8dece41483b7a18e',

       }).then((value) {
         business =value.data['articles'];
         print(business.length);
     emit(Newgetbussinessuccessedstate());
   }).catchError((e) {
     emit(Newgetbussineerrorstate(e.toString()));
     print(e.toString());
   });


 }

  List<dynamic> sports =[];

  getsports(){
    emit(Newgetbussinessloadingstate());
    if(sports.length==0) {
      diohelper.get(
          path: 'v2/top-headlines',
          qurery: {
            'country': 'us',
            'category': 'sports',
            'apiKey': '72288b3259c1493a8dece41483b7a18e',

          }).then((value) {
        sports = value.data['articles'];
        print(sports.length);
        emit(Newgetsportssuccessedstate());
      }).catchError((e) {
        emit(Newgetsportserrorstate(e.toString()));
        print(e.toString());
      });
    } else{
      emit(Newgetsportssuccessedstate());
    }


  }


  List<dynamic> science =[];

  getscience(){
    emit(Newgetscienceloadingstate());
    if(science.length==0) {
      diohelper.get(
          path: 'v2/top-headlines',
          qurery: {
            'country': 'us',
            'category': 'science',
            'apiKey': '72288b3259c1493a8dece41483b7a18e',

          }).then((value) {
        science = value.data['articles'];
        print(science.length);
        emit(Newgetsciencesuccessedstate());
      }).catchError((e) {
        emit(Newgetscienceerrorstate(e.toString()));
        print(e.toString());
      });
    }
    else{
      emit(Newgetsciencesuccessedstate());
    }

  }


List<dynamic> search =[];

  getsearch(String value){
    emit(Newgetscienceloadingstate());
    // search =[];
    diohelper.get(
          path: 'v2/everything',
          qurery: {
            'q': '$value',
            'apiKey': '72288b3259c1493a8dece41483b7a18e',
          }).then((value) {
        search = value.data['articles'];
        // print(search.length);
        emit(Newgetsearchsuccessedstate());
      }).catchError((e) {
        emit(Newgetsearcherrorstate(e.toString()));
        print(e.toString());
      });

      emit(Newgetsearchsuccessedstate());

  }


  bool isdark =false;

 // void changeMode({
 //    bool? fromchared}){
 //    if(fromchared != null) {
 //      isdark = fromchared;
 //      emit(Newthememodegstate());
 //    }
 //    else {
 //      isdark = !isdark;
 //      print("Newthememodegstate  11111");
 //      cashehelper.putboolean(key: "isDark", value: isdark).then((value) {
 //        emit(Newthememodegstate());
 //      });
 //    }
 //  }


}