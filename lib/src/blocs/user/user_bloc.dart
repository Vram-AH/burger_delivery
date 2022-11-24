import 'package:burger_delivery/src/models/models.dart';
import 'package:burger_delivery/src/services/services.dart';
import 'package:burger_delivery/src/utilities/utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<LoadUserData>((event, emit) async {
      emit(UserIsLoading());
      String uid = await Commons().getUID();
      final result = await UserService().loadUserData(uid);
      emit(
        result.fold(
          (l) => UserIsFailed(message: l),
          (r) => UserIsSuccess(data: r),
        ),
      );
    });
    on<LogOutUser>((event, emit) async {
      UserService().logOutUser();
      await Commons().removeUID();
      emit(UserIsLogOut());
    });
    on<ChangePhoto>((event, emit) async {
      final result =
          await UserService().changeProfile((state as UserIsSuccess).data);
      emit(
        result.fold(
          (l) => UserIsFailed(message: l),
          (r) => UserIsSuccess(data: r),
        ),
      );
    });
  }
}
