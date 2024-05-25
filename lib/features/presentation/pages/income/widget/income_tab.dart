import 'package:fixit_partner/features/features.dart';
import 'package:fixit_partner/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IncomeTab extends StatelessWidget {
  const IncomeTab({super.key, required this.time, required this.orders});

  final String time;
  final List<RepairOrder> orders;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    int income = 0;
    DateTime now = DateTime.now();
    String keterangan = '';

    if (time == 'Hari') {
      keterangan = '';
    } else if (time == 'Minggu') {
      keterangan = '(senin - minggu)';
    } else if (time == 'Bulan') {
      keterangan = '(${DateFormat.MMMM().format(now)})';
    }

    for (var order in orders) {
      income = income + order.totalCost!;
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('$time ini'),
                    const SizedBox(width: 4),
                    Text(
                      keterangan,
                      style: textTheme.labelSmall,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Rp${toThousand(income)}',
                    style: textTheme.titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.file_copy_outlined, size: 15),
                    const SizedBox(width: 5),
                    Text(
                      '${orders.length} pesanan selesai',
                      style: textTheme.labelSmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: SizedBox(
              height: 32,
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),
                child: const Text('Lihat detail'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
