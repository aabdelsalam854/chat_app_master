import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'stories_state.dart';

class StoriesCubit extends Cubit<StoriesState> {
  StoriesCubit() : super(StoriesInitial());
}
