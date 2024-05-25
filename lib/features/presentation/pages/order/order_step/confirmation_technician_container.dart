import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';
import 'package:fixit_partner/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ConfirmationTechnicianContainer extends StatefulWidget {
  const ConfirmationTechnicianContainer({super.key, required this.repairOrder});

  final RepairOrder repairOrder;

  @override
  State<ConfirmationTechnicianContainer> createState() =>
      _ConfirmationTechnicianContainerState();
}

class _ConfirmationTechnicianContainerState
    extends State<ConfirmationTechnicianContainer> {
  late GlobalKey<FormState> keyForm;
  late TextEditingController conReason;

  @override
  void initState() {
    keyForm = GlobalKey<FormState>();
    conReason = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    keyForm.currentState?.dispose();
    conReason.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    void accept() {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(
            Strings.of(context)!.accept,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          content: Text(
            Strings.of(context)!.acceptDesc,
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
                final params = widget.repairOrder;
                context.read<OrderCubit>().acceptOrder(params);
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

    Future<void> reject() async {
      showDialog(
        context: context,
        builder: (_) => Dialog(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimens.space24,
              vertical: Dimens.space16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(children: [
                  Text(
                    Strings.of(context)!.reject,
                    style: textTheme.bodyLarge,
                  )
                ]),
                SpacerV(value: Dimens.space16),
                Text(Strings.of(context)!.rejectDesc),
                Form(
                  key: keyForm,
                  child: TextF(
                    controller: conReason,
                    maxLine: null,
                    minLine: 3,
                    validator: (String? value) => value == null || value.isEmpty
                        ? Strings.of(context)!.errorEmptyField
                        : null,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: Text(
                        Strings.of(context)!.cancel,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context)
                                  .extension<MyAppColors>()!
                                  .subtitle,
                            ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (keyForm.currentState?.validate() ?? false) {
                          final params = widget.repairOrder
                              .copyWith(reasonCancelled: conReason.text);
                          context.read<OrderCubit>().rejectOrder(params);
                          context.pop();
                        }
                      },
                      child: Text(
                        Strings.of(context)!.yes,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context)
                                  .extension<MyAppColors>()!
                                  .blue,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        RowText(
          left: Strings.of(context)!.service,
          right: Strings.of(context)!.electronicRepair,
        ),
        RowText(
          left: Strings.of(context)!.electronics,
          right: context
              .read<ElectronicCubit>()
              .electronics
              .firstWhere(
                  (element) => element.id == widget.repairOrder.electronicId)
              .name!,
        ),
        RowText(
          left: Strings.of(context)!.client,
          right: context
              .read<ClientCubit>()
              .clients
              .firstWhere(
                  (element) => element.uid == widget.repairOrder.clientUid)
              .name!,
        ),
        RowText(
          left: Strings.of(context)!.orderTime,
          right: toDateTime(widget.repairOrder.dateTime!),
        ),
        RowText(
          left: Strings.of(context)!.clientLocation,
          right: widget.repairOrder.clientAddress!,
        ),
        RowText(
          left: Strings.of(context)!.distance,
          right: '${toKiloMeter(widget.repairOrder.distance!)} Km',
        ),
        RowText(
          left: Strings.of(context)!.estimatedTime,
          right: '${toMinute(widget.repairOrder.duration!)} '
              '${Strings.of(context)!.minutes}',
        ),
        RowText(
          left: Strings.of(context)!.checkingCost,
          right: 'Rp${toThousand(widget.repairOrder.checkingCost!)}',
        ),
        SpacerV(value: Dimens.space16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: reject,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).hintColor,
                foregroundColor: Palette.background,
                minimumSize: Size(160.w, 40.w),
              ),
              child: Text(Strings.of(context)!.reject),
            ),
            FilledButton(
              onPressed: accept,
              style: FilledButton.styleFrom(
                foregroundColor: Palette.background,
                minimumSize: Size(160.w, 40.w),
              ),
              child: Text(Strings.of(context)!.accept),
            ),
          ],
        ),
      ],
    );
  }
}
