import 'package:bloc/bloc.dart';
import 'package:chat_master/core/model/user_model.dart';
import 'package:chat_master/features/home/domain/usecases/messages.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.usecases) : super(HomeInitial());
  final MessagesUsecases usecases;

  Future<void> getUsers() async {
    emit(GetUsersLoadingState());
    var data = await usecases.getUserMessages('userId');
    data.fold(
      (failure) {
        emit(GetUsersErrorState(failure.msg));
      },
      (users) {
        emit(GetUsersSuccessState(users));
      },
    );
  }
}
