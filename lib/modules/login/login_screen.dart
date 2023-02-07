import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Shared/components/components.dart';
import 'package:shop_app/Shared/components/constants.dart';
import 'package:shop_app/Shared/network/local/cachehelper.dart';
import 'package:shop_app/layout/ShopApp_screen.dart';
import 'package:shop_app/modules/login/cubit/login_cubit.dart';
import 'package:shop_app/modules/login/cubit/login_states.dart';
import 'package:shop_app/modules/register/Register_screen.dart';

class MyLoginScreen extends StatefulWidget {
  const MyLoginScreen({Key? key}) : super(key: key);

  @override
  State<MyLoginScreen> createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MyLoginScreen> {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var Formkey = GlobalKey<FormState>();
  bool IsVisible = true;
  var KeyValidate = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (BuildContext context) => login_Cubit(),
        child: BlocConsumer<login_Cubit, login_states>(
          listener: (context, state) {
            if (state is loginsuccessStates) {
              if (state.login.status) {
                print(state.login.data!.token);
                print(state.login.message);

                // Fluttertoast.showToast(
                //     msg: state.login.message,
                //     toastLength: Toast.LENGTH_LONG,
                //     gravity: ToastGravity.BOTTOM,
                //     timeInSecForIosWeb: 5,
                //     backgroundColor: Colors.green,
                //     textColor: Colors.white,
                //     fontSize: 16.0
                // );

                ShowToast(message: state.login.message, state: ToastColorState.success);
                    token=state.login.data!.token;
                cashehelper.Savedata(
                        value: state.login.data!.token, key: 'token')
                    .then((value) {
                  NavigatorAndFinsh(context, ShopApp_Home_screen());
                });
              } else {
                print(state.login.message);
                ShowToast(
                    state: ToastColorState.error, message: state.login.message);
              }
            }
          },
          builder: (context, state) => Container(
            color: Colors.white,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Form(
                    key: Formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Login",
                            style: /*TextStyle(color: Colors.black, fontSize: 30,fontWeight: FontWeight.bold)*/ Theme
                                    .of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 30.0,
                        ),
                        const Text('login now to browse our hot offers',
                            style: TextStyle(
                                color: Colors.black12,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 30.0,
                        ),
                        TextformfirldBuilder(
                            labelTextstyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                                fontSize: 20),
                            labelText: 'Email address',
                            keyboard: TextInputType.text,
                            ValidateFunction: (String? value) {
                              if (value!.isEmpty) {
                                return 'Email mustn\'t =be empty';
                              } else {
                                return null;
                              }
                            },
                            prefixIcon: Icons.email_outlined,
                            controller: emailController),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextformfirldBuilder(
                            Ispass: ispass,
                            labelTextstyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                                fontSize: 20),
                            labelText: 'Password',
                            keyboard: TextInputType.text,
                            ValidateFunction: (String? value) {
                              if (value!.isEmpty) {
                                return 'Password mustn\'t =be empty';
                              } else {
                                return null;
                              }
                            },
                            ValidateFunction5: () {
                              if (Formkey.currentState!.validate()) {
                                login_Cubit.get(context).UserLogin(
                                    Email: emailController.text,
                                    password: passController.text);
                              }
                            },
                            prefixIcon: Icons.password_outlined,
                            suffixIcon: login_Cubit().ChangePassVisibility(),
                            ValidateFunction4: () async {
                              setState(() {
                                ispass = !ispass;
                              });
                            },
                            controller: passController),
                        const SizedBox(
                          height: 30.0,
                        ),
                        state is! loginLooadingStates
                            ? defaultButton(
                                function1: () {

                                  if (Formkey.currentState!.validate()) {
                                    login_Cubit.get(context).UserLogin(
                                        Email: emailController.text,
                                        password: passController.text);
                                  }
                                },
                                text: 'login',
                                IsUpperCase: true)
                            : Center(child: const CircularProgressIndicator()),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'don\'t have an account ?',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigatorbuilder(
                                        context,  MyRegisterScreen());
                                  },
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData IsSuffixVisIIble() {
    return IsVisible ? Icons.visibility : Icons.visibility_off;
  }
}
