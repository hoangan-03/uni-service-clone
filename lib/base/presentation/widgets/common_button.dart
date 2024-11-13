import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/domain/base_state.dart';
import 'package:flutter_base_v2/base/presentation/widgets/common.dart';
import 'package:flutter_base_v2/utils/gen/colors.gen.dart';

Widget primaryOutlinedButton({
  Widget? child,
  Widget? leadIcon,
  required String label,
  double? width,
  double height = 40,
  Function()? onPressed,
  Color fillColor = Colors.white,
  Color fillColorInactive = ColorName.grayHigh60,
  Color? borderColor,
  double borderWidth = 2,
  bool enabled = true,
  BorderRadiusGeometry? borderRadius,
  BaseState? state,
}) {
  return SizedBox(
    width: width,
    height: height,
    child: CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: enabled ? onPressed : null,
      child: Container(
          alignment: Alignment.center,
          decoration: ShapeDecoration(
            color: enabled ? fillColor : fillColorInactive,
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(100),
              side: BorderSide(
                width: borderWidth,
                color: borderColor ?? Colors.black,
              ),
            ),
          ),
          child: state != null
              ? state.widget(
                  onLoading: const LoadingWidget(),
                  onEmpty: child ??
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (leadIcon != null)
                            Container(
                              margin: const EdgeInsets.only(right: 8),
                              child: leadIcon,
                            ),
                          Text(
                            label,
                            style: AppTextStyle.bold18()
                                .copyWith(color: Colors.black),
                          ),
                        ],
                      ))
              : child ??
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (leadIcon != null)
                        Container(
                          margin: const EdgeInsets.only(right: 8),
                          child: leadIcon,
                        ),
                      Text(
                        label,
                        style: AppTextStyle.bold18()
                            .copyWith(color: Colors.black),
                      ),
                    ],
                  )),
    ),
  );
}
