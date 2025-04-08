part of 'theme_cubit.dart';

class ThemeState extends Equatable {
   final AppTheme appTheme;

 const ThemeState(this.appTheme);
  @override
  List<Object> get props => [ appTheme];
}

final class ThemeInitial extends ThemeState {
  const ThemeInitial(super.appTheme);
}

final class ThemeChanged extends ThemeState {
  const ThemeChanged(super.appTheme);



  @override
  List<Object> get props => [appTheme];
}

