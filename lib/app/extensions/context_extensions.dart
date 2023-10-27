import 'package:flutter/material.dart';

//theme extension on context
extension AppThemeEx on BuildContext {
  ThemeData get appTheme => Theme.of(this);
}

// media query extension on context
extension MediaQueryEx on BuildContext {
  MediaQueryData get mq => MediaQuery.of(this);

  Size get sizePx => mq.size;

  double get widthPx => sizePx.width;

  double get heightPx => sizePx.height;

  EdgeInsets get paddingPx => mq.padding;

  EdgeInsets get viewPadding => mq.viewPadding;

  EdgeInsets get viewInsets => mq.viewInsets;
}

//navigation extension on context
extension NavigationEx on BuildContext {
  NavigatorState get navigator => Navigator.of(this);

  void pop<T>([Object? T]) => navigator.pop(T);
}
