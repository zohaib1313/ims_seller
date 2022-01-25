import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ims_seller/styles.dart';

typedef FieldValidator = String? Function(String? data);

class SvgViewer extends StatelessWidget {
  final String svgPath;
  final double? height;
  final double? width;
  final Color? color;

  const SvgViewer(
      {Key? key, required this.svgPath, this.height, this.width, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (height != null) {
      return SvgPicture.asset(
        svgPath,
        color: color,
        height: height,
      );
    } else if (width != null) {
      return SvgPicture.asset(
        svgPath,
        width: width,
      );
    } else {
      return SvgPicture.asset(svgPath);
    }
  }
}

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  final Color? fillColor;
  final String? labelText;
  final String? hintText;
  final Color? hintColor;
  final Color? labelColor;
  final String? prefixIcon;
  final String? suffixIcon;
  final Color? focusBorderColor;
  final Color? unfocusBorderColor;
  final double? contentPadding;
  final bool? enable;
  final String? text;
  final String? sufixLabel;

  // ignore: prefer_typing_uninitialized_variables
  final onChanged;
  final double? leftPadding;
  final double? rightPadding;
  final TextEditingController? controller;
  final Function? focusListner;
  late FocusNode focusNode;
  final FieldValidator? validator;
  final TextInputType? keyboardType;
  final bool isDigitsOnly;
  final bool? obsecureText;
  final Widget? suffixIconWidet;
  TextDirection? textDirection;

  MyTextField(
      {Key? key,
      this.textDirection,
      this.obsecureText,
      this.fillColor,
      this.labelText,
      this.hintText,
      this.hintColor,
      this.labelColor,
      this.prefixIcon,
      this.suffixIcon,
      this.focusBorderColor,
      this.unfocusBorderColor,
      this.onChanged,
      this.contentPadding,
      this.enable = true,
      this.isDigitsOnly = false,
      this.text,
      this.sufixLabel,
      this.leftPadding,
      this.rightPadding,
      this.controller,
      this.focusListner,
      this.validator,
      this.suffixIconWidet,
      this.keyboardType})
      : super(key: key) {
    focusNode = FocusNode();
    if (focusListner != null) {
      focusNode.addListener(() {
        if (!focusNode.hasFocus) {
          focusListner!();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: leftPadding ?? 100.w,
        right: rightPadding ?? 100.w,
      ),
      child: TextFormField(
        obscureText: obsecureText ?? false,
        controller: controller ?? TextEditingController(),
        initialValue: text,
        inputFormatters:
            isDigitsOnly ? [FilteringTextInputFormatter.digitsOnly] : [],
        keyboardType: keyboardType ?? TextInputType.text,
        enabled: enable,
        focusNode: focusNode,
        validator: validator,
        onChanged: onChanged,
        autofocus: false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(contentPadding ?? 30.h),
          fillColor: fillColor,
          labelText: labelText,
          hintText: hintText,
          hintStyle: TextStyle(color: hintColor),
          labelStyle: TextStyle(color: labelColor),
          prefixIcon: (prefixIcon != null)
              ? Padding(
                  padding: EdgeInsets.all(100.w),
                  child: SvgViewer(svgPath: prefixIcon!),
                )
              : null,
          suffixIcon: sufixLabel != null
              ? Padding(
                  padding: EdgeInsets.all(25.h),
                  child: Text(
                    sufixLabel ?? '',
                  ),
                )
              : (suffixIcon != null)
                  ? Padding(
                      padding: EdgeInsets.all(25.h),
                      child: SvgViewer(
                        svgPath: suffixIcon!,
                        width: 20.w,
                        height: 20.h,
                      ),
                    )
                  : (suffixIconWidet != null)
                      ? suffixIconWidet
                      : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide:
                BorderSide(color: focusBorderColor ?? AppColor.blackColor),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: focusBorderColor ?? AppColor.blackColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: unfocusBorderColor ?? AppColor.blackColor),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.redColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: focusBorderColor ?? AppColor.blueColor),
          ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String buttonText;
  final onTap;
  final double? padding;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final double? leftPadding;
  final double? rightPading;

  Button(
      {Key? key,
      required this.buttonText,
      this.onTap,
      this.padding,
      this.color,
      this.textColor,
      this.borderColor,
      this.textStyle,
      this.width,
      this.height,
      this.leftPadding,
      this.rightPading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onDoubleTap: () {},
      child: Padding(
        padding: EdgeInsets.only(
            left: leftPadding == null ? 100.w : leftPadding!,
            right: rightPading == null ? 100.w : rightPading!),
        child: Container(
          width: width,
          height: height,
          padding: EdgeInsets.all(padding ?? 100.w),
          decoration: BoxDecoration(
              border: borderColor == null
                  ? null
                  : Border.all(
                      color: borderColor!,
                    ),
              borderRadius: BorderRadius.all(Radius.circular(50.r)),
              color: color ?? AppColor.blackColor),
          child: Center(
              child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: textStyle ??
                AppTextStyles.mediumBold
                    .copyWith(color: textColor ?? AppColor.blackColor),
          )),
        ),
      ),
    );
  }
}
