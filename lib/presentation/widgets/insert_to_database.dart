import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/sql/cubit.dart';
import '../../business_logic/cubit/sql/states.dart';

class SaveToDatabase extends StatelessWidget {
  const SaveToDatabase({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SqlCubit, SqlStates>(builder: (context, state) {
      return SqlCubit.get(context).insertToDatabase(title: text);
    });
  }
}
