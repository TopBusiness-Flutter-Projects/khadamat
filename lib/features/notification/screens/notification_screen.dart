import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamat/core/utils/app_colors.dart';

import '../cubit/nottification_cubit.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NottificationCubit, NottificationState>(

      builder: (context, state) {
        NottificationCubit cubit = context.read<NottificationCubit>();

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0,right: 12,top: 85,bottom: 12),
              child: ListView.builder(
                itemCount: cubit.notificationList.length,
                itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text("${cubit.notificationList[index].title}"),
                    subtitle: Text("${cubit.notificationList[index].body}"),
                  ),);
              },),
            ),
          ),
        );
      },
    );
  }
}
