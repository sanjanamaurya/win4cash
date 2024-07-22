import 'package:win4cash/generated/assets.dart';
import 'package:win4cash/res/aap_colors.dart';
import 'package:win4cash/res/app_constant.dart';
import 'package:win4cash/res/components/text_widget.dart';
import 'package:win4cash/res/provider/services/splash_service.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    // Future.delayed(Duration(seconds: 5), () {
    //   showDialog(context: context, builder: (context)=>OffersScreen());
    // });
    super.initState();
    splashServices.checkAuthentication(context);

  }

  @override
  Widget build(BuildContext context) {
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
          height: heights,
          width: widths,
          decoration: const BoxDecoration(
            gradient: AppColors.primaryUnselectedGradient,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: heights*0.40,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: AssetImage(Assets.imagesSplashImage),fit: BoxFit.cover)
                ),
              ),
              const SizedBox(height: 20),
              textWidget(
                  text: 'Withdraw fast, safe and stable',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryTextColor),
              const SizedBox(height: 5),
              textWidget(
                  text: 'Quick withdraw',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryTextColor),
              const SizedBox(height: 50),
              // Image.asset(Assets.imagesAppBarSecond, height: 50),
              const Text(AppConstants.appName,style:
              TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold,fontSize: 40),
              )

            ],
          ),
        ));
  }
}
