import 'package:flutter/material.dart';
import 'package:todo_app/app/extensions/context_extensions.dart';
import 'package:todo_app/app/themes/app_theme.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.onPressed,
    super.key,
    this.child,
    this.gradient,
    this.color,
    this.borderColor,
    this.borderWidth = 1,
    this.borderLess = false,
    this.underlinedText = false,
    this.invertedColor = false,
    this.textColor,
    this.textSize = 18,
    this.fontWeight,
    this.iconColor,
    this.iconSize,
    this.image,
    this.elevation = 0,
    this.width,
    this.height = 56,
    this.radius = 12,
    this.borderRadius,
    this.contentPadding = 10,
    this.iconAndTextPadding = 10,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.fastOutSlowIn,
    this.text,
    this.icon,
    this.textStyle,
    this.textHeight,
  });

  final Widget? child;
  final Gradient? gradient;
  final Color? color;
  final Color? borderColor;
  final double borderWidth;
  final Color? textColor;
  final double textSize;
  final FontWeight? fontWeight;
  final Color? iconColor;
  final double? iconSize;
  final String? text;
  final IconData? icon;
  final TextStyle? textStyle;
  final double? textHeight;
  final String? image;
  final bool borderLess;
  final bool underlinedText;
  final bool invertedColor;
  final double elevation;
  final double? width;
  final double height;
  final double radius;
  final BorderRadius? borderRadius;
  final double contentPadding;
  final double iconAndTextPadding;
  final Duration animationDuration;
  final Curve animationCurve;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Center(
      child: AnimatedContainer(
        duration: animationDuration,
        curve: animationCurve,
        decoration: BoxDecoration(
          gradient: gradient,
          color: gradient != null
              ? null
              : color != null && !invertedColor
                  ? color
                  : Colors.transparent,
          borderRadius: borderRadius ?? BorderRadius.circular(radius),
          border: borderLess
              ? null
              : Border.all(
                  width: borderWidth,
                  color: color == null
                      ? (borderColor ?? theme.greyScale200)
                      : invertedColor
                          ? color!
                          : borderColor ?? Colors.transparent,
                ),
        ),
        clipBehavior: Clip.antiAlias,
        child: AnimatedSize(
          duration: animationDuration,
          curve: animationCurve,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: (color == null
                      ? theme.greyScale200
                      : invertedColor
                          ? color!
                          : textColor ?? Colors.white)
                  .withOpacity(.2),
              highlightColor: Colors.transparent,
              onTap: onPressed,
              child: SizedBox(
                width: width == null ? null : width! - (borderWidth * 2),
                height: height - (borderWidth * 2),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: contentPadding),
                  child: AnimatedDefaultTextStyle(
                    duration: animationDuration,
                    curve: animationCurve,
                    style: textStyle ??
                        theme.textTheme.displayMedium!.copyWith(
                          decoration:
                              underlinedText ? TextDecoration.underline : null,
                          color: textColor,
                          fontSize: textSize,
                          fontWeight: fontWeight,
                          height: textHeight,
                        ),
                    child: Center(
                      child: child ??
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (image != null)
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 15, 15),
                                  child: Image(
                                    image: AssetImage(image!),
                                  ),
                                ),
                              if (icon != null)
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: text != null
                                          ? iconAndTextPadding
                                          : 0),
                                  child: Icon(
                                    icon,
                                    color: iconColor ??
                                        (color != null && invertedColor
                                            ? color
                                            : theme.colorScheme.background),
                                    size: iconSize ?? 30,
                                  ),
                                ),
                              if (text != null)
                                Flexible(
                                  child: Text(
                                    text!,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                            ],
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
