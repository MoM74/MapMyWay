import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import '../../business_logic/cubit/sql/cubit.dart';
import '../../constnats/my_colors.dart';

Widget buildSearchItem(Map model, context) {
  var subTitle =
      '${model['title']}'.replaceAll('${model['title']}'.split(',')[0], '');
  return Dismissible(
    key: Key(model['id'].toString()),
    child: Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.all(8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: MyColors.lightBlue),
              child: const Icon(
                Icons.place,
                color: MyColors.blue,
              ),
            ),
            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${'${model['title']}'.split(',')[0]}\n',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: subTitle.substring(2),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
    onDismissed: (direction) {
      SqlCubit.get(context).deleteData(
        id: model['id'],
      );
    },
  );
}

Widget historyBuilder({
  required List<Map> search,
}) =>
    ConditionalBuilder(
      condition: search.isNotEmpty,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) {
          return buildSearchItem(search[index], context);
        },
        separatorBuilder: (context, index) => myDivider(),
        itemCount: search.length,
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.search_outlined,
              size: 100.0,
              color: Colors.grey,
            ),
            Text(
              'No Search Yet',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );
