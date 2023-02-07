import 'package:flutter/material.dart';
import 'package:shop_app/Shared/components/components.dart';
import 'package:shop_app/Shared/network/local/cachehelper.dart';
import 'package:shop_app/Shared/styles/colors.dart';
import 'package:shop_app/models/onboarding_model.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onBorading_Screen extends StatefulWidget {
  onBorading_Screen({Key? key}) : super(key: key);

  @override
  State<onBorading_Screen> createState() => _onBorading_ScreenState();
}

class _onBorading_ScreenState extends State<onBorading_Screen> {
  List<onboardingModel> onboardinglist = [
    onboardingModel(
        title: 'WELCOME ',
        body: 'متجرنا يرحب بكم جميعاا',
        image: 'assets/images/shopping_2-transformed.png'),
    onboardingModel(
        title: 'SHOPPING',
        body: 'يمكنك الان التسوق بكل الطرق',
        image: 'assets/images/lapWithVisacard.jpg'),
    onboardingModel(
        title: 'OPINION',
        body: 'يسعدنا تقديم لكل جميع الخدمات الممتازه',
        image: 'assets/images/shopping_2-transformed.png'),
  ];

  onsubmit() {
    cashehelper.Savedata(key: 'Isboarding', value: true).then((value) {
      if (value) {
        NavigatorAndFinsh(context, MyLoginScreen());
      }
    });
  }

  var pageboardController = PageController();
  bool isthird = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [TextButton(onPressed:
        (){
          cashehelper.Savedata(key: 'Isboarding', value: true).then((value) {
            if (value) {
              NavigatorAndFinsh(context, MyLoginScreen());
            }
          });
        }
        /*onsubmit(),*/, child: const Text('Skip'))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(27.0),
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
              onPageChanged: (index) {
                if (index == onboardinglist.length - 1) {
                  setState(() {
                    isthird = true;
                  });
                } else {
                  setState(() {
                    isthird = false;
                  });
                }
              },
              controller: pageboardController,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  bulidBoardingItem(onboardinglist[index]),
              itemCount: onboardinglist.length,
            )
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageboardController,
                  count: onboardinglist.length,
                  effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                      activeDotColor: defaultcolor,
                      expansionFactor: 4,
                      spacing: 5),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isthird) {
                      // onsubmit();
                      cashehelper.Savedata(key: 'Isboarding', value: true).then((value) {
                        if (value) {
                          NavigatorAndFinsh(context, MyLoginScreen());
                        }
                      });
                    } else {
                      pageboardController.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_outlined),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget bulidBoardingItem(onboardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Text(
            '${model.title}',
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            '${model.body}',
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 40.0,
          ),
        ],
      );
}
