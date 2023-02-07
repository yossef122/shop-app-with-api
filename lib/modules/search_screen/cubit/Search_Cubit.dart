

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Shared/components/constants.dart';
import 'package:shop_app/Shared/network/endPoints.dart';
import 'package:shop_app/Shared/network/remotly/diohelper.dart';
import 'package:shop_app/models/Search_model/search_model.dart';
import 'package:shop_app/modules/search_screen/cubit/Search_states.dart';

class Search_Cubit extends Cubit<Search_States>{
  Search_Cubit():super(SearchIntialState());
  static Search_Cubit get(context)=>BlocProvider.of(context);

    late Search_model? model;
      SearchData(
          String? text
          )  {
          emit(SearchloadingState());
            diohelper.postData(
            path: Search,
            token: token,
            data: {
              'text':text
                  }
        ).then((value) {
          model = Search_model.fromJson(value.data);
          emit(SearchsucessState());
        }).catchError((error) {
          print(error.toString());
          emit(SearcherrorState());
        });
      }

    }