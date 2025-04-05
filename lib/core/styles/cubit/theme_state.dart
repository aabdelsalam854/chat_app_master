part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  @override
  List<Object> get props => [];
}

final class ThemeInitial extends ThemeState {}

final class ThemeChanged extends ThemeState {
  final AppTheme appTheme;
  ThemeChanged(this.appTheme);
  @override
  List<Object> get props => [appTheme];
}

