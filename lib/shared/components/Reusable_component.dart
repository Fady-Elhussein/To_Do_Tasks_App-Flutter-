import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/shared/cubit/cubit.dart';
import '../cubit/states.dart';


Widget defulttextformfiled({
  required controller,
  required keyboardType,
  bool obscureText = false,
  required String text,
  required Icon prefixIcon,
  IconButton? suffixIcon,
  GestureTapCallback? onTap,
  required String? Function(String?) validator,
}) =>
    TextFormField(
      controller: controller,
      onTap: onTap,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        labelText: text,
        contentPadding: EdgeInsets.all(25.0),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(),
      ),
    );


Widget buildTasksItem(Map Model, context) => Dismissible(
//Dismissible is a widget that can be dismissed
// by swiping in the indicated direction.
      key: Key(Model['id'].toString()),
  direction: DismissDirection.endToStart,
  onDismissed: (direction) {
    AppCubit.get(context).deleteData(id: Model['id']);
  },
  background: Container(
    color: Colors.red,
    child: Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Delete',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ),
  ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              backgroundColor: Colors.blue,
              child: Text(
                '${Model['time']}',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: 50,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${Model['title']}',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text('${Model['date']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      )),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: 'done', id: Model['id']);
              },
              icon: Icon(
                Icons.check_box,
                color: Colors.green,
              ),
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: 'archive', id: Model['id']);
              },
              icon: Icon(
                Icons.archive,
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
      ),


    );


Widget buildTasksList({
  required List<Map> tasks,
  required String statusofpage,
  required IconData iconofpage,
}) =>
    tasks.length <= 0
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconofpage,
                  size: 100.0,
                  color: Colors.grey,
                ),
                Text(
                  '$statusofpage',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          )
        : BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return ListView.separated(
                itemBuilder: (context, index) =>
                    buildTasksItem(tasks[index], context),
                separatorBuilder: (context, index) => Container(
                  height: 2.0,
                  color: Colors.grey,
                ),
                itemCount: tasks.length,
              );
            },
          );
