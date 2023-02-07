import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Shared/components/components.dart';
import 'package:shop_app/layout/shop_cubit/ShopCubit.dart';
import 'package:shop_app/layout/shop_cubit/ShopStates.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);
  var nameControler = TextEditingController();
  var emailControler = TextEditingController();
  var phoneControler = TextEditingController();
  var Formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener:(context,state){
          if (state is ShopUpadateUserSuccessState) {
            if (ShopCubit.get(context).userData!.status !=null &&ShopCubit.get(context).userData!.status ==true ) {
              // Fluttertoast.showToast(
              //     msg: state.login.message,
              //     toastLength: Toast.LENGTH_LONG,
              //     gravity: ToastGravity.BOTTOM,
              //     timeInSecForIosWeb: 5,
              //     backgroundColor: Colors.green,
              //     textColor: Colors.white,
              //     fontSize: 16.0
              // );

              ShowToast(message: 'Update data sucess',
                  state: ToastColorState.success);
            }
            else {
              ShowToast(
                  state: ToastColorState.error, message: 'Update data Error Try again');
            }
              }
        },
      builder:(context,state) {
        // ShopCubit.get(context).getUserData();
        var model=ShopCubit.get(context).userData!.data;
       nameControler.text=model!.name;
       emailControler.text=model.email;
       phoneControler.text=model.phone;
        return /*ShopCubit.get(context).UserData!=null*/state is! ShopGettingUserLoadingState  ?
        Form(
          key: Formkey,
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if(state is ShopUpadateUserLoadingState)
                      const LinearProgressIndicator(),
                  const SizedBox(
                    height: 20,
                  ),
                  defaulTextFormFied(
                      labelText: "Name",
                      PrefixIcon: Icons.person,
                      controller: nameControler,
                      keyboard: TextInputType.text,
                      ValidateFunction: (String? value) {
                        if (value!.isEmpty) {
                          return 'name mustn\'t be empty';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  defaulTextFormFied(
                      labelText: "Email",
                      PrefixIcon: Icons.email_outlined,
                      controller: emailControler,
                      keyboard: TextInputType.text,
                      ValidateFunction: (value) {
                        if (value.isEmpty) {
                          return 'name mustn\'t be empty';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  defaulTextFormFied(
                      labelText: "Phone",
                      PrefixIcon: Icons.email_outlined,
                      controller: phoneControler,
                      keyboard: TextInputType.text,
                      ValidateFunction: ( value) {
                        if (value.isEmpty) {
                          return 'name mustn\'t be empty';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                      defaultButton(
                          text: 'Update Data',
                     function1: (){
                            if(Formkey.currentState!.validate())
                           {
                             ShopCubit.get(context).UpadateUserData(
                                 name:nameControler.text,
                                 phone:phoneControler.text ,
                                 email: emailControler.text
                           );
                           }
                          },
                      IsUpperCase: false),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultButton(text: 'Sign Out', function1: (){
                          SignOut(context);
                        }, IsUpperCase: false),
                    ],
                  )
              ),
            ),
        ):
        const Center(child: CircularProgressIndicator());
      },
    );
  }
}
