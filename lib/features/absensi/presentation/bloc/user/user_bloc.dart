import 'package:absensi_pegawai/features/absensi/domain/entities/user.dart';
import 'package:absensi_pegawai/features/absensi/domain/usecases/user/get_user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUser getUser;

  UserBloc(this.getUser) : super(UserInitial()) {
    on<GetUserEvent>(_getUser);
  }

  Future<void> _getUser(GetUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      User userModel = await getUser();
      emit(UserSuccess(data: userModel));
    } catch (e) {
      emit(UserFailure());
    }
  }
}
