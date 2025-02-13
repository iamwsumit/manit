
import 'package:flutter/material.dart';

class Dimen {
  static const double sidebar_padding_horizontal = 15;
  static const double sidebar_padding_veritcal = 16;
  static const double sidebar_spacing = 15;
  static const double sidebar_item_font_size = 19;
  static const double sidebar_divider_thickness = 1;

  static TextStyle getSidebarTextStyle(BuildContext context) {
    return TextStyle(
        fontFamily: 'regular',
        fontWeight: FontWeight.w600,
        fontSize: Dimen.sidebar_item_font_size,
        height: 1,
        color: Theme.of(context).textTheme.headlineSmall?.color);
  }

  static TextStyle getListViewTitleStyle(BuildContext context) {
    return TextStyle(
        color: Theme.of(context).textTheme.headlineSmall?.color,
        fontWeight: FontWeight.bold,
        fontFamily: 'regular',
        fontSize: 19);
  }

  static TextStyle getListViewSubTitleStyle(BuildContext context) {
    return TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).unselectedWidgetColor);
  }

  static const BorderRadius listViewCardRadius =
  BorderRadius.all(Radius.circular(6));

  static Padding getListViewPadding({required Widget child}) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: child);
  }

  static const EdgeInsets listViewLayoutPadding =
  EdgeInsets.symmetric(vertical: 17, horizontal: 15);
  static const EdgeInsets listViewCardMargin =
  EdgeInsets.symmetric(vertical: 7, horizontal: 2);
  static const double listViewRowSpacing = 10;
}