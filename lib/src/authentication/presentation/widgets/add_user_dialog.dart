import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_repository_pattern_base/src/authentication/presentation/cubit/cubit/authentication_cubit.dart';

class AddUserDialog extends StatelessWidget {
  const AddUserDialog({required this.nameController, super.key});

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Username"
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  const String avatar = 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png';
                  final String name = nameController.text.trim();
                  context.read<AuthenticationCubit>().createUser(
                    createdAt: DateTime.now().toString(), 
                    name: name, 
                    avatar: avatar);

                  nameController.text = "";
                  Navigator.of(context).pop();

                }, 
                child: const Text("Save"))
            ],
          ),
        ),
      ),
    );
  }
}