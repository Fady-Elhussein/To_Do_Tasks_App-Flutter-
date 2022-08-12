import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/shared/cubit/cubit.dart';
import '../../shared/components/Reusable_component.dart';
import '../../shared/cubit/states.dart';
class DoneScreen extends StatefulWidget {
  @override
  State<DoneScreen> createState() => _DoneScreen();
}

class _DoneScreen extends State<DoneScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit ,AppStates>(
        listener:(BuildContext context,AppStates state) {},
      builder:(BuildContext context,AppStates state) {
        return buildTasksList(
            tasks: AppCubit.get(context).Donetasks,
        statusofpage: 'No Tasks Done Yet  !',
          iconofpage: Icons.check_circle_outline,

        );
      },
    );
}
}
