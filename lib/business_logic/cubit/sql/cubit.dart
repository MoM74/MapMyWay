import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import 'states.dart';

class SqlCubit extends Cubit<SqlStates> {
  SqlCubit() : super(SqlInitialState());

  static SqlCubit get(context) => BlocProvider.of(context);

  late Database database;
  List<Map> search = [];

  void createDatabase() {
    openDatabase(
      'maps.db',
      version: 1,
      onCreate: (database, version) {
        debugPrint('database created');
        database
            .execute(
                'CREATE TABLE MAPS (id INTEGER PRIMARY KEY, title TEXT, status TEXT)')
            .then((value) {
          debugPrint('table created');
        }).catchError((error) {
          debugPrint('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        debugPrint('database opened');
      },
    ).then((value) {
      database = value;
      emit(SqlCreateDatabaseState());
    });
  }

  insertToDatabase({
    required String title,
  }) async {
    return database.transaction((txn) {
      return txn
          .rawInsert(
        'INSERT INTO MAPS(title,status) VALUES("$title", "new")',
      )
          .then((value) {
        debugPrint('$value inserted successfully');
        emit(SqlInsertDatabaseState());

        getDataFromDatabase(database);
      }).catchError((error) {
        debugPrint('Error When Inserting New Record ${error.toString()}');
      });
    });
  }

  void getDataFromDatabase(database) {
    search = [];

    emit(SqlGetDatabaseLoadingState());

    database.rawQuery('SELECT * FROM MAPS').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          search.add(element);
        }
      });

      emit(SqlGetDatabaseState());
    });
  }

  void deleteData({
    required int? id,
  }) async {
    database.rawDelete('DELETE FROM MAPS WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(SqlDeleteDatabaseState());
    });
  }
}
