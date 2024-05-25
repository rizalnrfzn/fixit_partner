import 'package:cached_network_image/cached_network_image.dart';
import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';
import 'package:fixit_partner/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

class DetailTab extends StatelessWidget {
  const DetailTab({super.key, required this.repairOrder});

  final RepairOrder repairOrder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FilledButton(
        onPressed: () {
          context.read<ChatCubit>().readChat(
                ReadChatParams(
                  context.read<ChatCubit>().chatList.firstWhere(
                      (element) => element.clientUid == repairOrder.clientUid),
                ),
              );
          context.push(
            Routes.roomChat.path,
            extra: {
              'chatListId': context
                  .read<ChatCubit>()
                  .chatList
                  .firstWhere(
                      (element) => element.clientUid == repairOrder.clientUid)
                  .id,
              'clientName': context
                  .read<ClientCubit>()
                  .clients
                  .firstWhere((element) => element.uid == repairOrder.clientUid)
                  .name,
              'clientPicture': context
                  .read<ClientCubit>()
                  .clients
                  .firstWhere((element) => element.uid == repairOrder.clientUid)
                  .profilePicture,
            },
          );
        },
        style: FilledButton.styleFrom(
          foregroundColor: Palette.background,
          minimumSize: Size(400.w, 40.w),
        ),
        child: Text(Strings.of(context)!.chat),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(Dimens.space16),
              padding: EdgeInsets.symmetric(
                horizontal: Dimens.space24,
                vertical: Dimens.space12,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: Theme.of(context).hintColor.withOpacity(0.3),
              ),
              child: Column(
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
                            (element) => element.id == repairOrder.electronicId)
                        .name!,
                  ),
                  RowText(
                    left: Strings.of(context)!.client,
                    right: context
                        .read<ClientCubit>()
                        .clients
                        .firstWhere(
                            (element) => element.uid == repairOrder.clientUid)
                        .name!,
                  ),
                  RowText(
                    left: Strings.of(context)!.orderTime,
                    right: toDateTime(repairOrder.dateTime!),
                  ),
                  RowText(
                    left: Strings.of(context)!.clientLocation,
                    right: repairOrder.clientAddress!,
                  ),
                  RowText(
                    left: Strings.of(context)!.distance,
                    right: '${toKiloMeter(repairOrder.distance!)} Km',
                  ),
                  RowText(
                    left: Strings.of(context)!.estimatedTime,
                    right: '${toMinute(repairOrder.duration!)} '
                        '${Strings.of(context)!.minutes}',
                  ),
                  RowText(
                    left: Strings.of(context)!.checkingCost,
                    right: 'Rp${toThousand(repairOrder.checkingCost!)}',
                  ),
                ],
              ),
            ),
            GripeContainer(gripe: repairOrder.gripe!),
            if (repairOrder.electronicPicture != null &&
                repairOrder.electronicPicture!.isNotEmpty)
              Container(
                margin: EdgeInsets.all(Dimens.space16),
                padding: EdgeInsets.all(Dimens.space8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: Theme.of(context).hintColor.withOpacity(0.3),
                ),
                child: StaggeredGrid.count(
                  crossAxisCount: repairOrder.electronicPicture!.length > 2
                      ? 2
                      : repairOrder.electronicPicture!.length,
                  crossAxisSpacing: Dimens.space8,
                  mainAxisSpacing: Dimens.space8,
                  children: List.generate(
                    repairOrder.electronicPicture!.length,
                    (index) => StaggeredGridTile.fit(
                      crossAxisCellCount: 1,
                      child: Stack(
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(20.r),
                            onTap: () {
                              showAdaptiveDialog(
                                context: context,
                                builder: (_) => NetworkImageDialog(
                                  image: repairOrder.electronicPicture![index],
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.r),
                              child: SizedBox(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      repairOrder.electronicPicture![index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            SpacerV(value: 60.w),
          ],
        ),
      ),
    );
  }
}
