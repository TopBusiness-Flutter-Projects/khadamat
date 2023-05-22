import 'package:flutter/material.dart';

import '../preferences/preferences.dart';
import 'hex_color.dart';

class AppColors {
  static Color primary = HexColor('#FB2958');
  static Color secondPrimary = HexColor('#4455D7');
  static Color orangeThirdPrimary = HexColor('#FF9201');
  static final AppColors instance = AppColors._internal();
  static Color litePrimary = HexColor('#7F8CF3');

  AppColors._internal();

  factory AppColors() => instance;

  static Color scaffoldBackground = HexColor('#FDF5E8');
  static Color buttonBackground = HexColor('#594339');
  static Color textBackground = HexColor('#92603F');
  static Color onBoardingColor = HexColor('#DC8068');
  static Color containerBackgroundColor = HexColor('#F7DFB1');
  static Color iconBackgroundColor = HexColor('#402D26');
  static Color gray1 = HexColor('#404040');
  static Color unselectedTab = HexColor('#D9D9D9');
  static Color commentBackground = HexColor('#F3F2F2');
  static Color paymentContainer = HexColor('#F0D3AB');
  static Color textFormFieldColor = HexColor('#EDEDED');
  static Color descriptionBoardingColor = HexColor('#777777');
  static Color bottomNavigatorColor = HexColor('#F3F4F9');
  static Color unselectedTabColor = HexColor('#EEEEEE');
  static Color liveExamBackgroundColor = HexColor('#FFEAD7');
  static Color liveExamGrayTextColor = HexColor('#646463');
  static Color goldColor = HexColor('#F4BC35');
  static Color skyColor = HexColor('#48B8E0');
  static Color blueLiteColor = HexColor('#00B3DC');
  static Color redLiteColor = HexColor('#FEECEA');
  static Color greenDownloadColor = HexColor('#009541');

  static Color blueLikeColor = HexColor('#2e7dea');
  static Color redDislikeColor = HexColor('#ff2c2c');

  static Color green = HexColor('#15860B');
  static Color blueColor1 = HexColor('#6A85B6');
  static Color blueColor2 = HexColor('#BAC8E0');
  static Color blueColor3 = HexColor('#1877F2');
  static Color blueLiteColor1 = HexColor('#429993');
  static Color blueLiteColor2 = HexColor('#7CD4CC');

  static Color hint = Colors.grey;
  static Color blackLite = Colors.black54;
  static Color error = Colors.red;
  static Color success = Colors.green;
  static Color white = Colors.white;
  static Color black = Colors.black;
  static Color gray = Colors.grey;
  static Color grayLite = Colors.grey[700]!;
  static Color gray4 = HexColor('#C4C4C4');
  static Color gray5 = HexColor('#999999');
  static Color gray6 = HexColor('#A7A7A7');
  static Color gray7 = HexColor('#A0A1A0');
  static Color red = HexColor('#FF0000');
  static Color bink = HexColor('#FF9F9F');
  static Color purple1 = HexColor('#854AA4');
  static Color purple1light = HexColor('#E3D2FE');
  static Color blue = HexColor('#143A7B');
  static Color blue1 = HexColor('#CBDFF8');
  static Color blue2 = HexColor('#8290F8');
  static Color bluelight = HexColor('#D7EAF9');
  static Color orange = HexColor('#FE7C04');
  static Color orangelight = HexColor('#FFEAD7');
  static Color opacityWhite = Colors.white.withOpacity(0.5);
  static Color transparent = Colors.transparent;


  Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  Color lightens(String color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(HexColor(color));
    final hslLight = hsl.withLightness(
        (hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}