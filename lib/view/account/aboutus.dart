
import 'package:win4cash/main.dart';
import 'package:win4cash/res/aap_colors.dart';
import 'package:win4cash/res/components/app_bar.dart';
import 'package:win4cash/res/components/text_widget.dart';
import 'package:win4cash/res/helper/api_helper.dart';
import 'package:win4cash/res/provider/aboutus_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';

class Aboutus extends StatefulWidget {
  const Aboutus({super.key});

  @override
  State<Aboutus> createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {

  @override
  void initState() {
    fetchDataAboutus();
    // TODO: implement initState
    super.initState();
  }

  BaseApiHelper baseApiHelper = BaseApiHelper();

  @override
  Widget build(BuildContext context) {

    final dataabout = Provider.of<AboutusProvider>(context).aboutusData;

    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios_new_sharp,
                  color: Colors.white,
                )),
          ),
          centerTitle: true,
          title: textWidget(
            text: 'About Us',
            fontWeight: FontWeight.w900,
            fontSize: 20,
            color: AppColors.primaryTextColor,
          ),
          gradient: AppColors.primaryUnselectedGradient),
      body: dataabout!= null?SizedBox(
        height: height,
        width: width,
        child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HtmlWidget(dataabout.description.toString(),textStyle: const TextStyle(color: AppColors.primaryTextColor),),
                ),

              ],
            )),


      ):Container(),
    ));
  }
  Future<void> fetchDataAboutus() async {
    try {
      final AbouttDataa = await  baseApiHelper.fetchaboutusData();

      if (AbouttDataa != null) {
        Provider.of<AboutusProvider>(context, listen: false).setUser(AbouttDataa);
      }
    } catch (error) {
      // Handle error here
    }
  }

}
