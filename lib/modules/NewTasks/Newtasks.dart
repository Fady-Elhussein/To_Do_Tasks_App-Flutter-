import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/shared/cubit/cubit.dart';
import '../../shared/components/Reusable_component.dart';
import '../../shared/cubit/states.dart';
class NewTasks extends StatefulWidget {
  @override
  State<NewTasks> createState() => _NewTasksState();
}
class _NewTasksState extends State<NewTasks> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit ,AppStates>(
      listener:(BuildContext context,AppStates state) {},
      builder:(BuildContext context,AppStates state) {
        return buildTasksList(
          tasks: AppCubit.get(context).Newtasks,
          statusofpage: 'No Tasks Yet , Please Add Some Tasks',
          iconofpage: Icons.list_alt_sharp,
        );
      },
    );


  }
}
