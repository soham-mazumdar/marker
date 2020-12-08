import 'package:flutter/material.dart';

ThemeData getThemeData() {
  return ThemeData(
      primaryColor: AppColors.primary,
      accentColor: AppColors.background,
      canvasColor: Colors.white,
      fontFamily: 'Montserrat',
      // textTheme: TextTheme(
      //   bodyText1: GoogleFonts.comfortaa(fontSize: 14, fontWeight: FontWeight.bold),
      //   // bodyText2: GoogleFonts.tulpenOne(fontSize: 30, fontWeight: FontWeight.w500,letterSpacing: 1),
      //   bodyText2: GoogleFonts.lobster(fontSize: 22, fontWeight: FontWeight.w500),
      //   // bodyText2: GoogleFonts.sail(fontSize: 26, fontWeight: FontWeight.w500),
      //   button: GoogleFonts.comfortaa(fontSize: 16, fontWeight: FontWeight.normal),
      //   // // caption: ,
      //   // headline1: GoogleFonts.comfortaa(fontSize: 20, fontWeight: FontWeight.bold),
      //   // headline2: GoogleFonts.comfortaa(fontSize: 20, fontWeight: FontWeight.bold),
      //   // headline3: GoogleFonts.comfortaa(fontSize: 20, fontWeight: FontWeight.bold),
      //   // headline4: GoogleFonts.comfortaa(fontSize: 20, fontWeight: FontWeight.bold),
      //   // headline5: GoogleFonts.comfortaa(fontSize: 20, fontWeight: FontWeight.bold),
      //   headline6: GoogleFonts.tulpenOne(fontSize: 30, fontWeight: FontWeight.w500, letterSpacing: 1),
      //   // overline: GoogleFonts.comfortaa(fontSize: 20, fontWeight: FontWeight.bold),
      //   // subtitle1: GoogleFonts.lobster(fontSize: 30, fontWeight: FontWeight.w500),
      //   subtitle2: GoogleFonts.comfortaa(fontSize: 16, fontWeight: FontWeight.normal),
      // ),
      primaryTextTheme: TextTheme(
        
      )
    );
}



MaterialColor createSwatch(int r, int g, int b, double o){
	Map<int, Color> swatch = {};
	List<int> opacities = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
	for(int opacity in opacities)
		swatch[opacity] = Color.fromRGBO(r, g, b, opacity/1000);
	return MaterialColor(
		Color.fromRGBO(r, g, b, o).value,
		swatch
	);
}

class AppColors{
	static final MaterialColor primary = createSwatch(255,220,228, 1);
  static final MaterialColor primary2 = createSwatch(255,226,231, 1);
  static final MaterialColor secondary = createSwatch(255,239,243, 1);  
  static final MaterialColor background = createSwatch(240,240,240, 1);
  // static final MaterialColor grey = createSwatch(141, 141, 141, 1);  
  // static final MaterialColor bgGrey = createSwatch(247, 247, 247, 1);  
}
