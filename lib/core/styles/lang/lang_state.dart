part of 'lang_cubit.dart';

abstract class LanguageState extends Equatable {
  @override
  List<Object> get props => [];
}

class LanguageInitial extends LanguageState {}

class LanguageChanged extends LanguageState {
  final String locale;

  LanguageChanged(this.locale);

  @override
  List<Object> get props => [locale];
}
