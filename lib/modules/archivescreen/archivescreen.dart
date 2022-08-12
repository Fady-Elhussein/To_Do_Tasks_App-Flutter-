import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/shared/cubit/cubit.dart';
import '../../shared/components/Reusable_component.dart';
import '../../shared/cubit/states.dart';
class ArchiveScreen extends StatefulWidget {
  @override
  State<ArchiveScreen> createState() => _ArchiveScreen();
}

class _ArchiveScreen extends State<ArchiveScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit ,AppStates>(
      listener:(BuildContext context,AppStates state) {},
      builder:(BuildContext context,AppStates state) {
        return buildTasksList(
          tasks: AppCubit.get(context).Archivetasks,
          statusofpage: 'No Tasks Archive Yet !',
          iconofpage: Icons.archive_outlined,
        );
      },
    );

  }
}

