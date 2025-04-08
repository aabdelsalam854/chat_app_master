import 'package:chat_master/config/themes/app_theme.dart';
import 'package:chat_master/core/enums/theme.dart';


final appThemeData = {
  AppTheme.themeLight: AppThemes.light(
    "IBMPlexSans",
      // appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
      // fontFamily: "Cairo",
      // scaffoldBackgroundColor: Colors.white,
      // colorScheme:
      //     ColorScheme.fromSeed(seedColor: AppColors.kCustomBottomColors),
      // inputDecorationTheme: TextFieldTheme.lightTextFieldTheme,
      // textButtonTheme: TextButtonStyle.light
      
      ),
  AppTheme.themeDark:AppThemes.dark(
  "IBMPlexSans",
    
  )
  
  
  //  ThemeData(
  //     brightness: Brightness.dark,
  //     fontFamily: "Cairo",
  //     inputDecorationTheme: TextFieldTheme.darkTextFieldTheme,
  //     textButtonTheme: TextButtonStyle.dark),
};
