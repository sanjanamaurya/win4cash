import 'package:flutter/material.dart';
import 'package:win4cash/res/aap_colors.dart';
import 'package:win4cash/res/app_constant.dart';


class SubTitle_Text extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final double? width;
  final TextAlign? textAlign;
  final int? maxLines;
  final bool? softWrap;
  final TextOverflow? overflow;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;
  SubTitle_Text({super.key, required this.text, this.fontSize, this.fontWeight, this.textColor, this.width, this.textAlign, this.maxLines, this.softWrap, this.overflow, this.padding, this.alignment}) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: padding,
      alignment:alignment ?? Alignment.center,
      child: Text(
          maxLines: maxLines,
          overflow: overflow,
          softWrap: softWrap,
          textAlign:textAlign,
          text,
          style:  TextStyle(//15
                fontSize: fontSize ?? MediaQuery.of(context).size.width/25,
                fontWeight:fontWeight ?? FontWeight.normal,
                fontStyle: FontStyle.normal,
                color: textColor ?? AppColors.bottomNavColor
            ),
          )

    );
    //   Text(Title==null?"":Title!,
    //   style: TextStyle(
    //       fontSize:fontSize==null?20:fontSize,
    //       fontWeight:fontWeight==null?FontWeight.normal:fontWeight,
    //       color: textColor==null?ColorConstant.whiteColor:textColor ),
    // );
  }
}


class TitleStyle extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final TextAlign? textAlign;
  final int? maxLines;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? width;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;

  const TitleStyle({super.key,required this.text, this.fontSize, this.fontWeight, this.textColor, this.textAlign, this.maxLines, this.softWrap, this.overflow,  this.width, this.alignment, this.padding}) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: padding,
      alignment: alignment ?? Alignment.center,
      child: Text(
          maxLines: maxLines,
          overflow: overflow,
          softWrap: softWrap,
          textAlign:textAlign,
          text,
          style: TextStyle(
                fontSize: fontSize ?? MediaQuery.of(context).size.width/21,
                fontWeight:fontWeight ?? FontWeight.normal,
                fontStyle: FontStyle.normal,
                color: textColor ?? AppColors.primaryTextColor

          )),
    );
    //   Text(Title==null?"":Title!,
    //   style: TextStyle(
    //       fontSize:fontSize==null?20:fontSize,
    //       fontWeight:fontWeight==null?FontWeight.normal:fontWeight,
    //       color: textColor==null?ColorConstant.whiteColor:textColor ),
    // );
  }
}


class Small_Text extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final double? width;
  final TextAlign? textAlign;
  final int? maxLines;
  final bool? softWrap;
  final TextOverflow? overflow;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;

  Small_Text({super.key, required this.text, this.fontSize, this.fontWeight, this.textColor, this.width, this.textAlign, this.maxLines, this.softWrap, this.overflow, this.padding, this.alignment}) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: width,
      alignment: alignment ?? Alignment.center,
      child: Text(
          maxLines: maxLines,
          overflow: overflow,
          softWrap: softWrap,
          textAlign:textAlign,
          text,//alike
          style:  TextStyle(
                fontSize: fontSize ?? MediaQuery.of(context).size.width/30,
                fontWeight:fontWeight ?? FontWeight.normal,
                fontStyle: FontStyle.normal,
                color: textColor ?? AppColors.filledColor

          )),
    );

  }
}