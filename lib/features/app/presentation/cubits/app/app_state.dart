part of 'app_cubit.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppInitial extends AppState {}

class GetPageState extends AppState {
  final int page;

  const GetPageState(this.page);
  @override
  List<Object> get props => [page];
}

class NextPageState extends AppState {
  final int index;

  const NextPageState(this.index);
  @override
  List<Object> get props => [index];
}

class PreviousPageState extends AppState {
  final int index;

  const PreviousPageState(this.index);
  @override
  List<Object> get props => [index];
}
