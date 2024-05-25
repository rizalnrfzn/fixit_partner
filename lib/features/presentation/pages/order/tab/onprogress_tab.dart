import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';
import 'package:fixit_partner/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnprogressTab extends StatefulWidget {
  const OnprogressTab({super.key});

  @override
  State<OnprogressTab> createState() => _OnprogressTabState();
}

class _OnprogressTabState extends State<OnprogressTab> {
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
                        element.cancelled != true &&
                        !(filterOnProgres.contains(element.status)))
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
                                element.cancelled != true &&
                                !(filterOnProgres.contains(element.status)))
                            .length,
                        (index) => BlocProvider(
                          create: (context) => sl<OrderTileCubit>(),
                          child: OrderListTile(
                            repairOrder: orders
                                .where((element) =>
                                    element.cancelled != true &&
                                    !(filterOnProgres.contains(element.status)))
                                .toList()[index],
                            showMap: true,
                          ),
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
