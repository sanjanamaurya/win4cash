// ignore_for_file: deprecated_member_use, no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:win4cash/res/app_constant.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:provider/provider.dart';
import 'package:win4cash/main.dart';
import 'package:flutter/foundation.dart';
import 'package:win4cash/generated/assets.dart';
import 'package:win4cash/res/aap_colors.dart';
import 'package:win4cash/res/api_urls.dart';
import 'package:win4cash/res/components/app_bar.dart';
import 'package:win4cash/res/helper/api_helper.dart';
import 'package:win4cash/res/provider/profile_provider.dart';
import 'package:win4cash/view/account/service_center/custmor_service.dart';
import 'package:win4cash/view/home/notification.dart';
import 'package:win4cash/view/home/widgets/category_elements.dart';
import 'package:win4cash/view/home/widgets/category_widgets.dart';
import 'package:win4cash/view/home/widgets/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:win4cash/view/home/widgets/winning_information.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    versionCheck();
    invitationRuleApi();

    // TODO: implement initState
    super.initState();
  }

  BaseApiHelper baseApiHelper = BaseApiHelper();
  int selectedCategoryIndex = 0;
  bool verssionview = false;

  @override
  Widget build(BuildContext context) {
    final userData = context.watch<ProfileProvider>();

    _launchURL2() async {
      var url = userData.apkLink.toString();
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    if(kIsWeb){
    } else {
      Future.delayed(const Duration(seconds: 3), () => showAlert(context));
    }


    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
          title: Image.asset(
            Assets.imagesAppBarSecond,
            height: 40,
          ),
          actions: [
            kIsWeb == true
                ? Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            _launchURL2();
                          },
                          child: Image.asset(
                            Assets.iconsDownloadbutton,
                            height: 30,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const NotificationScreen()));
                          },
                          child: Image.asset(
                            Assets.iconsProNotification,
                            height: 30,
                          ),
                        ),
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const NotificationScreen
                                      ()));
                      },
                      child: Image.asset(
                        Assets.iconsProNotification,
                        height: 30,
                      ),
                    ),
                  ),
          ],
          centerTitle: true,
          gradient: AppColors.primaryUnselectedGradient),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100.0),
        child: DraggableFab(
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CustomerCareService()));
            },
            child: Image.asset(
              Assets.iconsIconSevice,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              const SliderWidget(),
              Container(
                height: height * 0.07,
                margin: const EdgeInsets.only(right: 10, left: 10),
                decoration: BoxDecoration(
                    color: AppColors.filledColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    Image.asset(
                      Assets.iconsMicphone,
                      height: 30,
                    ),
                    SizedBox(width: width * 0.01),
                    _rotate(),
                    Image.asset(
                      Assets.iconsNotification,
                      height: 30,
                    ),
                  ],
                ),
              ),
              CategoryWidget(
                onCategorySelected: (index) {
                  setState(() {
                    selectedCategoryIndex = index;
                  });
                },
              ),
               CategoryElement(selectedCategoryIndex: selectedCategoryIndex),
              const WinningInformation(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _rotate() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        DefaultTextStyle(
          style: const TextStyle(fontSize: 12, color: Colors.white),
          child: SizedBox(
            width: width * 0.75,
            child: AnimatedTextKit(
              repeatForever: true,
              isRepeatingAnimation: true,
              animatedTexts: invitationRuleList.isEmpty
                  ? [RotateAnimatedText("")]
                  : invitationRuleList
                      .map((rule) => RotateAnimatedText(rule))
                      .toList(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void showAlert(BuildContext context) {
    verssionview == true
        ? showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => AlertDialog(
                  backgroundColor: AppColors.scaffolddark,
                  content: SizedBox(
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: width * 0.50,
                          height: height * 0.065,
                          child: const Image(
                            image: AssetImage(Assets.imagesAppBarSecond),
                            fit: BoxFit.fill,
                          ),
                        ),
                        const Text('new version are available',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                        Text(
                            'Update your app  ${AppConstants.appVersion}  to  $map',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          _launchURL();
                          if (kDebugMode) {
                            print(versionlink);
                            print("versionlink");
                          }
                        },
                        child: const Text("UPDATE"))
                  ],
                ))
        : Container();
  }

  List<String> invitationRuleList = [];
  Future<void> invitationRuleApi() async {
    final response = await http.get(
      Uri.parse('${ApiUrl.allRules}5'),
    );
    if (kDebugMode) {
      print('${ApiUrl.allRules}5');
      print('allRules');
    }
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        invitationRuleList =
            json.decode(responseData[0]['list']).cast<String>();
      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        invitationRuleList = [];
      });
      throw Exception('Failed to load data');
    }
  }

  dynamic map;
  dynamic versionlink;

  Future<void> versionCheck() async {
    context.read<ProfileProvider>().fetchProfileData();
    if (kDebugMode) {
      print('aaaaaaaaaaaaaaaaaaaa');
    }
    final response = await http.get(
      Uri.parse(ApiUrl.versionlink),
    );
    if (kDebugMode) {
      print(jsonDecode(response.body));
    }
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      if (kDebugMode) {
        print(responseData);
        print('rrrrrrrr');
      }
      if (responseData['version'] != AppConstants.appVersion) {
        setState(() {
          map = responseData['version'];
          versionlink = responseData['link'];
          verssionview = true;
        });
      } else {
        if (kDebugMode) {
          print('Version is up-to-date');
        }
      }
    } else {
      if (kDebugMode) {
        print('Failed to fetch version data');
      }
    }
  }

  _launchURL() async {
    var url = versionlink.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
