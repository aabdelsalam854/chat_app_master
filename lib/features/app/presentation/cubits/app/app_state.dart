part of 'app_cubit.dart';

abstract class AppState extends Equatable {
  final Locale locale;
  final String fontFamily;
  final AppTheme appTheme;
  const AppState(this.locale, this.fontFamily, this.appTheme);

  @override
  List<Object> get props => [ locale, fontFamily, appTheme];
}

class AppInitial extends AppState {

  const AppInitial(super.locale, super.fontFamily, super.appTheme);
 @override
  List<Object> get props => [ locale, fontFamily, appTheme];

}



class ChangeLocaleState extends AppState {
  const ChangeLocaleState(super.locale, super.fontFamily, super.appTheme);
   @override
  List<Object> get props => [ locale, fontFamily, appTheme];
}

final class ThemeChanged extends AppState {
  const ThemeChanged(super.locale, super.fontFamily, super.appTheme);

 @override
  List<Object> get props => [ locale, fontFamily, appTheme];
}
