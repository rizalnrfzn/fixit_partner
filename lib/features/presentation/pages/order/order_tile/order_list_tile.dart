import 'package:cached_network_image/cached_network_image.dart';
import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';
import 'package:fixit_partner/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class OrderListTile extends StatefulWidget {
  const OrderListTile({
    super.key,
    required this.repairOrder,
    required this.showMap,
  });

  final RepairOrder repairOrder;
  final bool showMap;

  @override
  State<OrderListTile> createState() => _OrderListTileState();
}

class _OrderListTileState extends State<OrderListTile> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<MyAppColors>()!;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimens.space12),
      child: Container(
        width: 380.w,
        decoration: BoxDecoration(
          color: Theme.of(context).extension<MyAppColors>()!.card!,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                context.push(Routes.orderDetail.path,
                    extra: widget.repairOrder.id);
              },
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30.r),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimens.space20,
                      vertical: Dimens.space16,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.r),
                      child: Container(
                        height: 117.w,
                        width: 117.w,
                        color: Theme.of(context).hintColor.withOpacity(0.3),
                        child: CachedNetworkImage(
                          imageUrl: context
                              .read<ClientCubit>()
                              .clients
                              .firstWhere((element) =>
                                  element.uid == widget.repairOrder.clientUid)
                              .profilePicture!,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 117.w,
                    width: 191.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context
                              .read<ClientCubit>()
                              .clients
                              .firstWhere((element) =>
                                  element.uid == widget.repairOrder.clientUid)
                              .name!,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        const Spacer(flex: 1),
                        Text(
                          Strings.of(context)!.electronicRepair,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        BlocBuilder<ElectronicCubit, ElectronicState>(
                          builder: (context, state) {
                            return Text(
                              context
                                  .read<ElectronicCubit>()
                                  .electronics
                                  .firstWhere((element) =>
                                      element.id ==
                                      widget.repairOrder.electronicId)
                                  .name!,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.bodyMedium,
                            );
                          },
                        ),
                        const Spacer(flex: 2),
                        Container(
                          decoration: BoxDecoration(
                            color: colorTheme.blue,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimens.space8,
                              vertical: Dimens.space4,
                            ),
                            child: Text(
                              (MainBoxMixin.mainBox
                                                  ?.get(MainBoxKeys.locale.name)
                                              as String? ??
                                          'id') ==
                                      'en'
                                  ? getStatus(widget.repairOrder.status!)
                                      .englishText
                                  : getStatus(widget.repairOrder.status!).text,
                              style: textTheme.bodyMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            FilledButton(
              onPressed: () {
                context.read<ChatCubit>().readChat(
                      ReadChatParams(
                        context.read<ChatCubit>().chatList.firstWhere(
                            (element) =>
                                element.clientUid ==
                                widget.repairOrder.clientUid),
                      ),
                    );
                context.push(
                  Routes.roomChat.path,
                  extra: {
                    'chatListId': context
                        .read<ChatCubit>()
                        .chatList
                        .firstWhere((element) =>
                            element.clientUid == widget.repairOrder.clientUid)
                        .id,
                    'clientName': context
                        .read<ClientCubit>()
                        .clients
                        .firstWhere((element) =>
                            element.uid == widget.repairOrder.clientUid)
                        .name,
                    'clientPicture': context
                        .read<ClientCubit>()
                        .clients
                        .firstWhere((element) =>
                            element.uid == widget.repairOrder.clientUid)
                        .profilePicture,
                  },
                );
              },
              style: FilledButton.styleFrom(
                foregroundColor: Palette.background,
                minimumSize: Size(332.w, 30.w),
              ),
              child: Text(Strings.of(context)!.chat),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimens.space24,
              ),
              child: Divider(
                  color: Theme.of(context).extension<MyAppColors>()!.shadow),
            ),
            if (isOpen)
              BlocBuilder<OrderCubit, OrderState>(
                builder: (_, __) {
                  context.read<OrderTileCubit>().checkStatus(widget.repairOrder,
                      context.read<LocationCubit>().currentLocation!);
                  return BlocBuilder<OrderTileCubit, OrderTileState>(
                    builder: (_, state) {
                      return state.when(
                          initial: () => Padding(
                                padding: EdgeInsets.all(Dimens.space24),
                                child: const Center(
                                  child: Loading(),
                                ),
                              ),
                          success: (index, direction) {
                            if (index == 0) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dimens.space24,
                                  vertical: Dimens.space16,
                                ),
                                child: ConfirmationTechnicianContainer(
                                  repairOrder: widget.repairOrder,
                                ),
                              );
                            } else if (index == 1) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dimens.space24,
                                  vertical: Dimens.space16,
                                ),
                                child: WaitingTechnicianContainer(
                                  repairOrder: widget.repairOrder,
                                  direction:
                                      context.read<OrderTileCubit>().direction!,
                                  mapHeight: 350.h,
                                  showMap: widget.showMap,
                                ),
                              );
                            } else if (index == 2) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dimens.space24,
                                  vertical: Dimens.space16,
                                ),
                                child: CheckingContainer(
                                  repairOrder: widget.repairOrder,
                                ),
                              );
                            } else if (index == 3) {
                              return SizedBox(
                                height: 300.h,
                                child: const Center(
                                  child: Text(
                                      'Menunggu konfirmasi dari pelanggan'),
                                ),
                              );
                            } else if (index == 4) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimens.space24,
                                    vertical: Dimens.space16),
                                child: ElectronicRepairContainer(
                                  repairOrder: widget.repairOrder,
                                ),
                              );
                            } else if (index == 5) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimens.space24,
                                    vertical: Dimens.space16),
                                child: PaymentContainer(
                                  repairOrder: widget.repairOrder,
                                ),
                              );
                            } else {
                              return SizedBox(
                                height: 400.h,
                                child: Center(
                                  child: Text('$index'),
                                ),
                              );
                            }
                          },
                          failure: (message) => Center(child: Text(message)));
                    },
                  );
                },
              ),
            InkWell(
              onTap: () {
                setState(() {
                  context.read<OrderTileCubit>().checkStatus(widget.repairOrder,
                      context.read<LocationCubit>().currentLocation!);

                  isOpen = !isOpen;
                });
              },
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: Dimens.space6,
                      bottom: Dimens.space12,
                    ),
                    child: isOpen
                        ? const Icon(Icons.keyboard_arrow_up_rounded)
                        : const Icon(Icons.keyboard_arrow_down_rounded),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
