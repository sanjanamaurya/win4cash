import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Decoration? decoration;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final Color? gradientColorOne;
  final Color? gradientColorTwo;
  final Color? shadowColor;
  final double? dx;
  final double? dy;
  final Gradient? gradient;
  final String? Label;
  final TextStyle? style;
  final IconData? icon;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final Color? iconColor;
  final Color? textColor;
  final double? fontSize;
  final AlignmentGeometry? begin;
  final AlignmentGeometry? end;
  final double? blurRadius;
  final double? spreadRadius;
  final Widget? child;
  final BorderRadiusGeometry? borderRadius;
  final BlurStyle? blurStyle;
  final List<BoxShadow>? boxShadow;
  final void Function()? onTap;
  final BoxBorder? border;
  final DecorationImage? image;
  final BoxConstraints? constraints;
  CustomContainer({
    this.alignment,
    this.padding,
    this.color,
    this.decoration,
    this.width,
    this.height,
    this.margin,
    this.gradientColorOne,
    this.gradientColorTwo,
    this.shadowColor,
    this.dx,
    this.dy,
    this.gradient,
    this.Label,
    this.style,
    this.icon,
    this.fontWeight,
    this.fontStyle,
    this.iconColor,
    this.textColor,
    this.fontSize,
    this.begin,
    this.end,
    this.blurRadius,
    this.spreadRadius,
    this.child,
    this.borderRadius,
    this.blurStyle,
    this.boxShadow,
    this.onTap,
    this.border,
    this.image,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    final widths = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: alignment,
        margin: margin,
        padding: padding,
        height: height,
        width: width ?? widths,
        constraints: constraints,
        decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(5),
            color: color,
            gradient: gradient,
            boxShadow: boxShadow,
            border: border,
            image: image
          // LinearGradient(
          //   begin: begin==null?Alignment.topLeft:begin!, end: end==null?Alignment.bottomRight:end!,
          //   colors: [
          //    color == null? gradientColorOne==null?ColorConstant.gradientLightGreen:gradientColorOne!:Colors.transparent,
          //     gradientColorTwo==null? ColorConstant.gradientLightblue:gradientColorTwo!
          //   ],
          // ),

          // [
          //   BoxShadow(
          //       spreadRadius:spreadRadius==null?0:spreadRadius!,
          //       blurRadius: blurRadius==null?0:blurRadius!,
          //       color: shadowColor==null?Colors.black.withOpacity(0.5):shadowColor!,
          //       offset: Offset(dx==null?0:dx!,dy==null?0:dy!),
          //     blurStyle: blurStyle==null?BlurStyle.normal:blurStyle!
          //   )
          // ]
        ),
        child: child ??
            Row(
              children: [
                Text(
                  Label == null ? "" : Label!,
                  style: TextStyle(color: textColor, fontSize: fontSize),
                ),
                Icon(
                  icon,
                  color: iconColor,
                )
              ],
            ),
      ),
    );
  }
}