import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CheckingContainer extends StatefulWidget {
  const CheckingContainer({super.key, required this.repairOrder});

  final RepairOrder repairOrder;

  @override
  State<CheckingContainer> createState() => _CheckingContainerState();
}

class _CheckingContainerState extends State<CheckingContainer> {
  late GlobalKey<FormState> keyForm;
  late TextEditingController repairCost;
  List<TextF> textFields = [];
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    keyForm = GlobalKey<FormState>();
    repairCost = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    keyForm.currentState?.dispose();
    repairCost.dispose();
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  List<Widget> listTextFields() => List.generate(
        textFields.length,
        (index) => textFields[index],
      );

  void addForm() {
    final controller = TextEditingController();
    final textField = TextF(
      controller: controller,
      hintText: 'Masukkan Kerusakan',
      validator: (String? value) => value == null || value.isEmpty
          ? Strings.of(context)!.errorEmptyField
          : null,
    );

    setState(() {
      controllers.add(controller);
      textFields.add(textField);
    });
  }

  void submit() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          Strings.of(context)!.arrive,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        content: Text(
          'Anda yakin ingin dengan daftar kerusakan dan biaya berbaikan ini?',
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
                    color: Theme.of(context).extension<MyAppColors>()!.subtitle,
                  ),
            ),
          ),
          TextButton(
            onPressed: () {
              final List<String> damage =
                  controllers.map((e) => e.text).toList();
              final int totalCost =
                  int.parse(repairCost.text) + widget.repairOrder.checkingCost!;
              final params = widget.repairOrder.copyWith(
                damage: damage,
                repairCost: int.parse(repairCost.text),
                totalCost: totalCost,
              );

              context.read<OrderCubit>().checkingElectronic(params);
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: keyForm,
      child: Column(
        children: [
          Column(
            children: listTextFields(),
          ),
          ButtonText(
            title: 'Tambah form',
            onPressed: addForm,
          ),
          if (controllers.isNotEmpty)
            TextF(
              controller: repairCost,
              hintText: 'Masukkan biaya perbaikan',
              inputFormatter: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(16)
              ],
              validator: (String? value) => value == null || value.isEmpty
                  ? Strings.of(context)!.errorEmptyField
                  : null,
            ),
          FilledButton(
            onPressed: controllers.isEmpty
                ? null
                : () {
                    if (keyForm.currentState?.validate() ?? false) {
                      submit();
                    }
                  },
            style: FilledButton.styleFrom(
              foregroundColor: Palette.background,
              minimumSize: Size(332.w, 40.w),
            ),
            child: Text(Strings.of(context)!.send),
          )
        ],
      ),
    );
  }
}
