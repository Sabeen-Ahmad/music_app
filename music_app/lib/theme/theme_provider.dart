import 'package:flutter/material.dart';
import 'package:music_app/theme/dark_mode.dart';
import 'package:music_app/theme/light_mode.dart';
//step 1 to use provider state management
//Create a changenotifier class
class ThemeProvider extends ChangeNotifier{

  //initially light mode
  ThemeData _themeData = lightMode;
  //get these
ThemeData get themeData => _themeData;
//is dark mode
bool get isDarkMode => _themeData == darkMode;
//set theme
set themeData(ThemeData themeData){
  _themeData = themeData;
  //update UI
  notifyListeners();

}
//toggle theme
void toggleTheme(){
  if (_themeData == lightMode){
    themeData = darkMode;}
    else{
      themeData = lightMode;
  }
  }
}
