import 'package:chat_app/blocs/auth/auth_bloc.dart';
import 'package:chat_app/cubits/auth/auth_cubit.dart';
import 'package:chat_app/cubits/chat/chat_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // BlocOverrides.runZoned(
  //   () => runApp(const ScholarChat()),
  //   blocObserver: SimpleBlocObserver(),
  // );
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => ChatCubit(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
            useMaterial3: false,
            inputDecorationTheme: const InputDecorationTheme(
                counterStyle: TextStyle(
              color: Colors.white,
            ))),
        routes: {
          LoginPage.id: (context) => LoginPage(),
          RegisterPage.id: (context) =>  RegisterPage(),
          ChatPage.id: (context) => ChatPage(),
        },
        initialRoute: LoginPage.id,
      ),
    );
  }
}
