import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/sql/cubit.dart';
import '../../business_logic/cubit/sql/states.dart';
import '../widgets/places_history.dart';
/*
BlocBuilder<SqlCubit, SqlStates>(builder: (context, state) {
      return SqlCubit.get(context)
          .insertToDatabase(title: placeSuggestion.description);
    });
*/

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SqlCubit, SqlStates>(
      builder: (context, state) {
        var search = SqlCubit.get(context).search;
        return Scaffold(
          backgroundColor: Colors.grey,
          body: historyBuilder(
            search: search,
          ),
        );
      },
    );
  }
}
