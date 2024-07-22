
import 'package:win4cash/main.dart';
import 'package:win4cash/res/aap_colors.dart';
import 'package:win4cash/res/components/app_bar.dart';
import 'package:win4cash/res/components/app_btn.dart';
import 'package:win4cash/res/components/text_widget.dart';
import 'package:win4cash/res/helper/api_helper.dart';
import 'package:win4cash/res/provider/TermsConditionProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';


class TermsCondition extends StatefulWidget {
  const TermsCondition({super.key});

  @override
  State<TermsCondition> createState() => _TermsConditionState();
}

class _TermsConditionState extends State<TermsCondition> {

  @override
  void initState() {
    fetchtc(context);
    // TODO: implement initState
    super.initState();
  }

  BaseApiHelper baseApiHelper = BaseApiHelper();

  @override
  Widget build(BuildContext context) {

    final dataTc = Provider.of<TermsConditionProvider>(context).TcData;


    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
        leading: const AppBackBtn(),
          title: textWidget(
              text: 'Terms and Condition',
              fontSize: 25,
              color: AppColors.primaryTextColor),
          gradient: AppColors.primaryappbargrey),
      body: dataTc!= null?SizedBox(
        height: height,
        width: width,
        child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HtmlWidget(dataTc.description.toString(),textStyle: const TextStyle(color: AppColors.primaryTextColor)),
                ),
              ],
            )),
      ):Container(),
    ));
  }
  Future<void> fetchtc(context) async {
    try {
      final dataTerms = await  baseApiHelper.fetchdataTC();
      if (dataTerms != null) {
        Provider.of<TermsConditionProvider>(context, listen: false).setterms(dataTerms);
      }
    } catch (error) {
      // Handle error here
    }
  }

}
