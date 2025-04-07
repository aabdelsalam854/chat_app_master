part of 'locale_cubit.dart';

class LocaleState extends Equatable {
  final Locale locale;
  final String fontFamily;
  const LocaleState({required this.locale, required this.fontFamily});
  @override
  List<Object> get props => [locale];
}

class ChangeLocaleState extends LocaleState {
  const ChangeLocaleState({required super.locale, required super.fontFamily});
}
