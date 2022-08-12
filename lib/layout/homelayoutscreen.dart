import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/shared/cubit/states.dart';
import '../shared/components/Reusable_component.dart';
import '../shared/cubit/cubit.dart';

class homelayoutscreen extends StatelessWidget {
  @override
  var titlecontroller = TextEditingController();
  var dateController = TextEditingController();
  var timecontroller = TextEditingController();
  var scafoldkey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          return Scaffold(
            key: scafoldkey,
            appBar: AppBar(
              title: Center(
                  child: Text(AppCubit.get(context)
                      .titles[AppCubit.get(context).currentindex])),
              backgroundColor: AppCubit.get(context)
                  .colorsappbar[AppCubit.get(context).currentindex],
            ),
            floatingActionButton: AppCubit.get(context).currentindex==0?
              FloatingActionButton(
              child: Icon(AppCubit.get(context).fabicon),
              onPressed: () {
                //لو انا دست عليه و انا فاتحوا ادخل في ال if لو دوست و انا قافلوا ادخل في ال else
                if (AppCubit.get(context)
                    .isbottomsheetshown) //if isbottomsheetshown is True close
                {
                  if (formKey.currentState!.validate()) {
                    AppCubit.get(context)
                        .insertToDatabase(
                      title: titlecontroller.text,
                      time: timecontroller.text,
                      date: dateController.text,
                    )
                        .then((value) {
                      Navigator.pop(context);
                      AppCubit.get(context)
                          .Chnagebottomsheet(isShown: false, icon: Icons.edit);
                      titlecontroller.clear();
                      timecontroller.clear();
                      dateController.clear();
                    });
                  }
                } else {
                  scafoldkey.currentState
                      ?.showBottomSheet(
                        (context) => SingleChildScrollView(
                          child: BlocConsumer<AppCubit ,AppStates>(
                          listener:(BuildContext context,AppStates state) {},
                           builder:(BuildContext context,AppStates state) {
                          return Container(
                            color: AppCubit.get(context).Containercolor,
                            padding: EdgeInsets.all(
                              20.0,
                            ),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  defulttextformfiled(
                                      controller: titlecontroller,
                                      keyboardType: TextInputType.text,
                                      text: "Title",
                                      prefixIcon: Icon(Icons.label),
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter title';
                                        }
                                        return null;
                                      }),
                                  SizedBox(
                                    height: 25.0,
                                  ),
                                  defulttextformfiled(
                                      onTap: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2100),
                                        ).then((value) => dateController.text =
                                            DateFormat.yMMMd().format(value!));
                                      },
                                      controller: dateController,
                                      keyboardType: TextInputType.none,
                                      text: "Date",
                                      prefixIcon: Icon(Icons.calendar_today),
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter date';
                                        }
                                        return null;
                                      }),
                                  SizedBox(
                                    height: 25.0,
                                  ),
                                  defulttextformfiled(
                                      onTap: () {
                                        showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now())
                                            .then(
                                              (value) => timecontroller.text =
                                              value!.format(context).toString(),
                                        );
                                      },
                                      controller: timecontroller,
                                      keyboardType: TextInputType.none,
                                      text: 'TIme',
                                      prefixIcon: Icon(Icons.access_time),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter date';
                                        }
                                      }),
                                  SizedBox(
                                    height: 25.0,
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap:() {
                                          AppCubit.get(context).ChangeContainerColor(
                                              color:Color.fromRGBO(241, 241, 241, 1));
                                        },
                                        child: CircleAvatar(
                                          radius: 15.0,
                                          backgroundColor: Color.fromRGBO(241, 241, 241, 1),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      GestureDetector(
                                        onTap:() {
                                          AppCubit.get(context).ChangeContainerColor(
                                              color: Color.fromRGBO(226, 220, 200, 1));
                                        },
                                        child: CircleAvatar(
                                          radius: 15.0,
                                          backgroundColor: Color.fromRGBO(226, 220, 200, 1),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      GestureDetector(
                                        onTap:() {
                                          AppCubit.get(context).ChangeContainerColor(
                                              color: Color.fromRGBO(163, 228, 228, 1));
                                        },
                                        child: CircleAvatar(
                                          radius: 15.0,
                                          backgroundColor: Color.fromRGBO(163, 228, 228, 1),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),

                                    ],
                                  ),


                                ],
                              ),
                            ),
                          );
                          },
                          ),

                        ),
                      )
                      .closed
                      .then((value) {
                    AppCubit.get(context)
                        .Chnagebottomsheet(isShown: false, icon: Icons.edit);
                    titlecontroller.clear();
                    timecontroller.clear();
                    dateController.clear();
                  });
                  AppCubit.get(context)
                      .Chnagebottomsheet(isShown: true, icon: Icons.add);
                }
              },
            ):null,
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: AppCubit.get(context).colorsappbar[AppCubit.get(context).currentindex],
              unselectedItemColor: Colors.black87,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.list_alt_sharp),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: 'Archive',
                ),
              ],
              currentIndex: AppCubit.get(context).currentindex,
              onTap: (int index) {
                AppCubit.get(context).changeindex(index);
              },
            ),
            body: AppCubit.get(context)
                .screens[AppCubit.get(context).currentindex],
          );
        },
      ),
    );
  }
}
