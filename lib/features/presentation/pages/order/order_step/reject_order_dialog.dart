import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RejectOrderDialog extends StatefulWidget {
  const RejectOrderDialog({super.key});

  @override
  State<RejectOrderDialog> createState() => _RejectOrderDialogState();
}

class _RejectOrderDialogState extends State<RejectOrderDialog> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    GlobalKey<FormState> keyForm = GlobalKey<FormState>();
    TextEditingController connReason = TextEditingController();

    return Dialog(
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
            Text('Masukkan alasan Anda menolak pesanan ini'),
            TextF(
              controller: connReason,
              maxLine: null,
              minLine: 3,
              validator: (String? value) =>
                  value == null || value.isEmpty ? 'harus diisi' : null,
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
                      context.pop();
                    }
                  },
                  child: Text(
                    Strings.of(context)!.yes,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color:
                              Theme.of(context).extension<MyAppColors>()!.blue,
                        ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
