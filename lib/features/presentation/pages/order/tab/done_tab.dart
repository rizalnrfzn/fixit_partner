import 'package:fixit_partner/features/features.dart';
import 'package:fixit_partner/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoneTab extends StatelessWidget {
  const DoneTab({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> filterOnProgres = [
      Status.beriUlasan.name,
      Status.pesananSelesai.name,
    ];

    return BlocBuilder<OrderCubit, OrderState>(
      builder: (_, state) {
        return state.maybeWhen(
          orElse: () => const Center(
            child: Loading(),
          ),
          success: (orders) {
            return orders
                    .where((element) =>
                        (filterOnProgres.contains(element.status) &&
                            element.cancelled != true))
                    .isEmpty
                ? const Center(
                    child: Text('Tidak ada order'),
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(
                        orders
                            .where((element) =>
                                (filterOnProgres.contains(element.status) &&
                                    element.cancelled != true))
                            .length,
                        (index) => OrderDoneListTile(
                          repairOrder: orders
                              .where((element) =>
                                  (filterOnProgres.contains(element.status) &&
                                      element.cancelled != true))
                              .toList()[index],
                        ),
                      ),
                    ),
                  );
          },
        );
      },
    );
  }
}
