import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/app/extensions/context_extensions.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({
    super.key,
    this.isCentered = false,
    this.cupertino = false,
    this.adaptive = true,
    this.color,
    this.dimensions,
    this.strokeWidth = 4,
  });

  final bool isCentered;
  final bool cupertino;
  final bool adaptive;
  final Color? color;
  final double? dimensions;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final mColor = color ?? theme.primaryColor;
    final loader = (adaptive && Platform.isIOS) || cupertino
        ? CupertinoActivityIndicator(
            color: mColor,
            radius: 15,
          )
        : CircularProgressIndicator(
            color: mColor,
            strokeWidth: strokeWidth,
          );

    final child = dimensions != null
        ? SizedBox(width: dimensions, height: dimensions, child: loader)
        : loader;

    return isCentered ? Center(child: child) : child;
  }
}

class CustomBottomLoader extends StatelessWidget {
  const CustomBottomLoader({
    required this.reachedMax,
    required this.showLoader,
    super.key,
    this.isCentered = true,
    this.reachedMaxMessage,
  });

  final bool isCentered;
  final bool reachedMax;
  final String? reachedMaxMessage;
  final bool showLoader;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final loader = showLoader
        ? CircularProgressIndicator(color: theme.primaryColor)
        : null;
    return SizedBox(
      height: 40,
      child: isCentered
          ? Center(
              child: reachedMax
                  ? Text(reachedMaxMessage ?? 'You reached the end')
                  : loader,
            )
          : loader,
    );
  }
}
