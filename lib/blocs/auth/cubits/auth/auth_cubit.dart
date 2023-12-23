import 'package:bloc/bloc.dart';
import 'package:chat_app/blocs/auth/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> registerUser({
    required String email,
    required String password,
  }) async {
    emit(RegisterLoadingState());
    try {
      UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(RegisterSuccessState(user.user!.email!));
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        emit(RegisterFailureState('user not found'));
      } else if (ex.code == 'wrong-password') {
        emit(RegisterFailureState('wrong password'));
      }
    } catch (ex) {
      emit(RegisterFailureState('there was an error'));
    }
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    try {
      UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccessState(user.user!.email!));
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        emit(LoginFailureState('user not found'));
      } else if (ex.code == 'wrong-password') {
        emit(LoginFailureState('wrong password'));
      }
    } catch (ex) {
      emit(LoginFailureState('there was an error'));
    }
  }
}
