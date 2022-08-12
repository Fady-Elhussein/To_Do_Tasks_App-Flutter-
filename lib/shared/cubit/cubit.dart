import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/shared/cubit/states.dart';
import '../../modules/Donescreen/donescreen.dart';
import '../../modules/NewTasks/Newtasks.dart';
import '../../modules/archivescreen/archivescreen.dart';


class AppCubit extends Cubit<AppStates>  {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  // To make an object og cubit available to all the widgets in the app

  List<Color> colorsappbar= [Colors.blue, Colors.green, Colors.blueGrey];
  List<Widget> screens = [
    NewTasks(),
    DoneScreen(),
    ArchiveScreen(),
  ];
  List<String> titles = [
    'Tasks',
    'Done Tasks',
    'Archive Tasks',
  ];
  var currentindex = 0;
  void changeindex(int index)
  {
    currentindex=index;
    emit(AppBottomNavBarState());
  }
  Color Containercolor = Colors.white;
  void ChangeContainerColor({required Color color})
  {
    Containercolor =color;
    emit(AppChageContainerColorState());
  }

  bool isbottomsheetshown=false;
  IconData fabicon=Icons.edit;
  void Chnagebottomsheet({required bool isShown, required IconData icon})
  {
    isbottomsheetshown=isShown;
    fabicon=icon;
    emit(AppBottomSheetState());
  }


//Sqflite database

  late Database database;
  List<Map> Newtasks=[];
  List<Map> Donetasks=[];
  List<Map> Archivetasks=[];
  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database.execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getdatafromdatabase(database);
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDataBaseState());
    });
  }

  Future insertToDatabase(
      {
        required String title,
        required String time ,
        required String date ,
      }
      ) async {
    await database.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO TASKS(title,date,time,status) VALUES("$title","$date","$time","new")'
      ).then((value) {
        print('$value inserted successfully');
        emit(AppInserteDataBaseState());
        getdatafromdatabase(database);
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
    });
  }

  void updateData ({
    required String status,
    required int id,
  }
      ) async {
     database.rawUpdate(
        'UPDATE Tasks SET status = ? WHERE id = ?',
        ['$status', id],
     ).then((value) {
        getdatafromdatabase(database);
          emit(AppUpdateDataBaseState());
     });
  }

  void getdatafromdatabase(database) {
    Newtasks=[]; // to clear the list before fetching new data and avoid duplicates
    Donetasks=[];
    Archivetasks=[];
      database.rawQuery('SELECT * FROM TASKS').then((value) {
        value.forEach((element) {
        if(element['status']=='new')
        {
          Newtasks.add(element);
        }
        else if(element['status']=='done')
        {
          Donetasks.add(element);
        }
        else if(element['status']=='archive')
        {
          Archivetasks.add(element);
        }
      });
      emit(AppGetDataBaseState());
    });
  }

  void deleteData({
    required int id,
  }) async
  {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id])
        .then((value)
    {
      getdatafromdatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }
}

