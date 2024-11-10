import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_repository_pattern_base/core/errors/exceptions.dart';
import 'package:flutter_repository_pattern_base/src/authentication/presentation/cubit/cubit/authentication_cubit.dart';
import 'package:flutter_repository_pattern_base/src/authentication/presentation/widgets/add_user_dialog.dart';
import 'package:flutter_repository_pattern_base/src/authentication/presentation/widgets/loading_column.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextEditingController nameController = TextEditingController();

  void getUsers(){
    context.read<AuthenticationCubit>().getUsers();
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationError){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        }else if(state is UserCreated){
          getUsers();
        }else if(state is ServerException){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.toString())));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: state is GettingUsers  ?
              const LoadingColumn(message: 'Fetching Users')
            : state is CreatingUser ?
              const LoadingColumn(message: "Creating User ")
            : state is UsersLoaded ?
            ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, i){
                final user = state.users[i];
                return SizedBox(
                  child: ListTile(
                    leading: SizedBox(
                      width: 50, 
                      height: 50, 
                      child: Image.network("https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
                    ),
                    title: Text(user.name),
                    subtitle: Text(user.createdAt.substring(10)),
                  ),
                );
              }
              ) 
            : const SizedBox(),

          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              await showDialog(context: context, builder: (context) => AddUserDialog(nameController: nameController));
            },
            icon: const Icon(Icons.add),
            label: const Text("Add"),
          ),
        );
      },
    );
  }
}