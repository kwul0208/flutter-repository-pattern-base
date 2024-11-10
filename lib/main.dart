import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_repository_pattern_base/core/services/injection_container.dart';
import 'package:flutter_repository_pattern_base/src/authentication/presentation/cubit/cubit/authentication_cubit.dart';
import 'package:flutter_repository_pattern_base/src/authentication/presentation/views/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthenticationCubit>(),
      child: const MaterialApp(title: 'Flutter Demo', home: HomeScreen()),
    );
  }
}
