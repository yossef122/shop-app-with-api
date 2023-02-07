import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Shared/components/components.dart';
import 'package:shop_app/Shared/components/constants.dart';
import 'package:shop_app/Shared/network/local/cachehelper.dart';
import 'package:shop_app/layout/ShopApp_screen.dart';
import 'package:shop_app/modules/login/cubit/login_cubit.dart';
import 'package:shop_app/modules/register/cubit/Register_cubit.dart';
import 'package:shop_app/modules/register/cubit/Register_states.dart';

class MyRegisterScreen extends StatefulWidget {
  const MyRegisterScreen({Key? key}) : super(key: key);

  @override
  State<MyRegisterScreen> createState() => _MyRegisterScreenState();
}

class _MyRegisterScreenState extends State<MyRegisterScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var PhoneController = TextEditingController();
  var Formkey = GlobalKey<FormState>();
  bool IsVisible = true;
  var KeyValidate = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (BuildContext context) => Register_Cubit(),
        child: BlocConsumer<Register_Cubit, Register_states>(
          listener: (context, state) {
            if (state is RegistersuccessStates) {
              if (state.Register.status) {
                // print(state.Register.data!.token);
                // print(state.Register.message);
                ShowToast(message: state.Register.message, state: ToastColorState.success);
                token=state.Register.data!.token;
                cashehelper.Savedata(
                    value: state.Register.data!.token, key:'token')
                    .then((value) {
                  NavigatorAndFinsh(context, ShopApp_Home_screen());
                });
              } else {
                print(state.Register.message);
                ShowToast(
                    state: ToastColorState.error, message: state.Register.message);
              }
            }
          },
          builder: (context, state) => Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Form(
                  key: Formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Register",
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
                      const Text('Register now to browse our hot offers',
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
                          labelText: 'Name',
                          keyboard: TextInputType.name,
                          ValidateFunction: (String? value) {
                            if (value!.isEmpty) {
                              return 'Name mustn\'t =be empty';
                            } else {
                              return null;
                            }
                          },
                          prefixIcon: Icons.person,
                          controller: nameController),
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
                        height: 15.0,
                      ),
                      TextformfirldBuilder(
                          labelTextstyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                              fontSize: 20),
                          labelText: 'Phone',
                          keyboard: TextInputType.text,
                          ValidateFunction: (String? value) {
                            if (value!.isEmpty) {
                              return 'Phone Number mustn\'t be empty';
                            } else {
                              return null;
                            }
                          },
                          prefixIcon: Icons.phone,
                          controller: PhoneController),
                      const SizedBox(
                        height: 30.0,
                      ),
                      state is! RegisterLooadingStates
                          ? defaultButton(
                          function1: () {
                            if (Formkey.currentState!.validate()) {
                              Register_Cubit.get(context).UserRegister(
                                  Email: emailController.text,
                                  password: passController.text,
                                  name:nameController.text,
                                  phone:PhoneController.text
                              );
                            }
                          },
                          text: 'Register',
                          IsUpperCase: true)
                          : Center(child: const CircularProgressIndicator()),
                      const SizedBox(
                        height: 15.0,
                      ),

                    ],
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
