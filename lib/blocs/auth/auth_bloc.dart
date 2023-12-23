import 'package:bloc/bloc.dart';
import 'package:chat_app/blocs/auth/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoadingState());
        try {
          UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email,
            password: event.toString(),
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

      if (event is RegisterEvent) {
        emit(RegisterLoadingState());
        try {
          UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
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
    });
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}
