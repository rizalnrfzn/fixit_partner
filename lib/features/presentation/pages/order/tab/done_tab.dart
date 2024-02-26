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
          stream: (orders) {
            return orders
                    .where(
                        (element) => (filterOnProgres.contains(element.status)))
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
                                (filterOnProgres.contains(element.status)))
                            .length,
                        (index) => OrderDoneListTile(
                          repairOrder: orders
                              .where((element) =>
                                  (filterOnProgres.contains(element.status)))
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
