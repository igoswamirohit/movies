import 'dart:math';

import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension MediaQueryExtension on BuildContext {
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;

  double get lowValue => height * 0.01;
  double get normalValue => height * 0.02;
  double get mediumValue => height * 0.04;
  double get highValue => height * 0.1;
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colors => theme.colorScheme;
}

extension PaddingExtensionAll on BuildContext {
  EdgeInsets get paddingLow => EdgeInsets.all(lowValue);
  EdgeInsets get paddingNormal => EdgeInsets.all(normalValue);
  EdgeInsets get paddingMedium => EdgeInsets.all(mediumValue);
  EdgeInsets get paddingHigh => EdgeInsets.all(highValue);
}

extension PaddingExtensionSymetric on BuildContext {
  EdgeInsets get paddingLowVertical => EdgeInsets.symmetric(vertical: lowValue);
  EdgeInsets get paddingNormalVertical =>
      EdgeInsets.symmetric(vertical: normalValue);
  EdgeInsets get paddingMediumVertical =>
      EdgeInsets.symmetric(vertical: mediumValue);
  EdgeInsets get paddingHighVertical =>
      EdgeInsets.symmetric(vertical: highValue);

  EdgeInsets get paddingLowHorizontal =>
      EdgeInsets.symmetric(horizontal: lowValue);
  EdgeInsets get paddingNormalHorizontal =>
      EdgeInsets.symmetric(horizontal: normalValue);
  EdgeInsets get paddingMediumHorizontal =>
      EdgeInsets.symmetric(horizontal: mediumValue);
  EdgeInsets get paddingHighHorizontal =>
      EdgeInsets.symmetric(horizontal: highValue);
}

extension PageExtension on BuildContext {
  Color get randomColor => Colors.primaries[Random().nextInt(17)];
}

extension DurationExtension on BuildContext {
  Duration get lowDuration => Duration(milliseconds: 500);
  Duration get normalDuration => Duration(seconds: 1);
}

extension ModalExt on BuildContext {
  void showModal(Widget child) {
    showModalBottomSheet(
      context: this,
      backgroundColor: Colors.transparent,
      builder: (context) => child,
    );
  }
}

extension SnackBarExt on BuildContext {
  void showSnackbar(SnackBar snackBar) {
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}

extension NavigationExt on BuildContext {

  NavigatorState? get navigator => Navigator.of(this);

  Future<T?> push<T>(WidgetBuilder builder) async {
    return await navigator!.push<T>(MaterialPageRoute(builder: builder));
  }

  Future<T?> pushNamed<T>(String routeName) async {
    return await navigator!.pushNamed<T>(routeName);
  }

  void pop<T>([T? result]) => navigator!.pop<T>(result);

  /// Pushes the built widget to the screen using the material fade in animation
  void nextPage(Widget page, {bool maintainState = true}) =>
      _nextPage(context: this, page: page, maintainState: maintainState);

  /// Pushes and replacing the built widget to the screen using the material fade in animation
  void nextReplacementPage(Widget page, {bool maintainState = true}) =>
      _nextReplacementPage(
          context: this, page: page, maintainState: maintainState);

  /// Removing all the widgets till defined rule, and pushes the built widget to the screen using the material fade in animation
  void nextAndRemoveUntilPage(Widget page) =>
      _nextAndRemoveUntilPage(context: this, page: page);
}

Future<void> _nextPage(
        {required BuildContext context,
        required Widget page,
        bool maintainState = true}) async =>
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
          maintainState: maintainState,
        ));
Future<void> _nextReplacementPage(
        {required BuildContext context,
        required Widget page,
        bool maintainState = true}) async =>
    await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => page,
          maintainState: maintainState,
        ));
Future<void> _nextAndRemoveUntilPage(
        {required BuildContext context, required Widget page}) async =>
    await Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => page), (route) => false);
