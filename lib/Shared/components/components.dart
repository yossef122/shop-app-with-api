import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Shared/components/constants.dart';
import 'package:shop_app/Shared/network/local/cachehelper.dart';
import 'package:shop_app/layout/shop_cubit/ShopCubit.dart';
import 'package:shop_app/modules/login/login_screen.dart';
// import 'package:news_app/modules/web_view/web_view_screen.dart';

Widget BuildArticleItem (article,context)=>Container(
  height: 180.0,
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 160.0,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            image:article['urlToImage']!=null? DecorationImage(
                image: NetworkImage('${article['urlToImage']}'),
                fit: BoxFit.cover
            ) : DecorationImage(
                image: AssetImage('assets/images.png'),
                fit: BoxFit.cover
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text('${article['title']}' ,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: /*TextStyle(fontWeight: FontWeight.bold,fontSize: 20 ,color: Colors.black)*/
                  Theme.of(context).textTheme.bodyText1
                  ,

                ),
              ),
              Text('${article['publishedAt']}' ,
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20 ,color: Colors.grey),

              )
            ],
          ),
        )
      ],
    ),
  ),
);



Widget TextformfirldBuilder({
  required String labelText,
  IconData? prefixIcon,
  IconData? suffixIcon,
  required TextEditingController controller,
  required TextInputType keyboard,
  required ValidateFunction,
    ValidateFunction2,
    ValidateFunction4,
    ValidateFunction5,
  TextStyle? labelTextstyle,
  bool Ispass =false,
  // required ValidateFunction3,
}) =>
    TextFormField(
      onEditingComplete:ValidateFunction5 ,
      decoration: InputDecoration(
        label: Text("$labelText",style: labelTextstyle ,),
        labelStyle: const TextStyle(
            fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
        border: const OutlineInputBorder(),
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon != null
            ? IconButton(
          icon: Icon(suffixIcon),
          onPressed: ValidateFunction4,
        )
            : null,
      ),
      keyboardType: keyboard,
      controller: controller,
      validator: ValidateFunction,
      onChanged: ValidateFunction2,
      obscureText: Ispass ,
      // onTap: ValidateFunction3,
    );


Future Navigatorbuilder(context,Widget) => Navigator.push( context, MaterialPageRoute(builder:(context)=> Widget));
Future NavigatorAndFinsh(context,Widget) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context)=> Widget),
        (Route<dynamic>route) =>false, //عايز تلغي الي فاتت ولا تسبها موجوده
    );


Widget mydivider()=> Container(
  width: double.infinity,
  height: 1,
  color: Colors.grey[400],
);



Widget defaulTextFormFied({
  required String labelText,
  String? hinttext,
  required IconData PrefixIcon,
  IconData? SuffixIcon,
  bool Ispassword = false,
  TimelineAsyncFunction? function,
   onsubmit,
  required TextEditingController controller,
  required TextInputType keyboard,
  required ValidateFunction,
}) =>
    TextFormField(
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.red),
          hintText: hinttext,
          hintStyle: TextStyle(color: Colors.red),
          border: OutlineInputBorder(),
          prefixIcon: Icon(PrefixIcon),
          suffixIcon: SuffixIcon != null
              ? IconButton(
            icon: Icon(SuffixIcon),
            onPressed: function,
          )
              : null),
      keyboardType: keyboard,
      obscureText: Ispassword,
      controller: controller,
      validator: ValidateFunction,
      onChanged: onsubmit,
    );

Widget defaultButton({
  Color BackGround = Colors.blue,
  double width = double.infinity,
  double radius = 3,
  required String text,
  required  function1,
  required bool IsUpperCase,
}) =>
    Container(
      width: width,
      height: 50,
      child: ElevatedButton(
          onPressed: function1,
          child: Text(
            "${IsUpperCase ? text.toUpperCase() : text}",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),

          )
      ),
      // decoration: BoxDecoration(
      //     color: BackGround, borderRadius: BorderRadius.circular(radius)),
    );

void ShowToast({
  required message,
  required ToastColorState state ,

}){
  Fluttertoast.showToast(
      msg: message ,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor:toastColor(state) ,
      textColor: Colors.white,
      fontSize: 16.0
  );


}

enum ToastColorState{success,error,warning}

Color toastColor(
   ToastColorState state ,
    ){
    Color color ;
    switch(state)
    {
      case ToastColorState.success:
        color =Colors.green;
        break;

      case ToastColorState.error:
        color =Colors.red;
        break;
      case ToastColorState.warning:
        color =Colors.yellow;
        break;
    }
    return color;

}


void SignOut(context){
  cashehelper.RemoveData(key: 'token').then((value) {
    NavigatorAndFinsh(
        context,
        MyLoginScreen()
    );
  });
}

void printfullText(String Text){

  final patten=RegExp('.{1,800}');
  patten.allMatches(Text).forEach((element) {
    print(element.group(0));

  });
}

Widget BuildItemsView(model,context)=>Padding(
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
