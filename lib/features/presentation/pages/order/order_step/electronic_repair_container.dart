import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ElectronicRepairContainer extends StatelessWidget {
  const ElectronicRepairContainer({super.key, required this.repairOrder});

  final RepairOrder repairOrder;

  @override
  Widget build(BuildContext context) {
    void done() {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(
            Strings.of(context)!.done,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          content: Text(
            'Pastikan perbaikan elektronik sudah selesai',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: Text(
                Strings.of(context)!.cancel,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color:
                          Theme.of(context).extension<MyAppColors>()!.subtitle,
                    ),
              ),
            ),
            TextButton(
              onPressed: () {
                final params = repairOrder;
                context.read<OrderCubit>().electronicRepair(params);
                context.pop();
              },
              child: Text(
                Strings.of(context)!.yes,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).extension<MyAppColors>()!.blue,
                    ),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        const Text('Perbaikan Elektronik'),
        FilledButton(
          onPressed: done,
          style: FilledButton.styleFrom(
            foregroundColor: Palette.background,
            minimumSize: Size(428.w, 40.w),
          ),
          child: const Text('Electronik selesai diperbaiki'),
        ),
      ],
    );
  }
}
