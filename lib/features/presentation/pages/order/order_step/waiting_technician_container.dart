import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';
import 'package:fixit_partner/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';

class WaitingTechnicianContainer extends StatelessWidget {
  const WaitingTechnicianContainer({
    super.key,
    required this.repairOrder,
    required this.direction,
    required this.mapHeight,
    required this.showMap,
  });

  final RepairOrder repairOrder;
  final Direction direction;
  final double mapHeight;
  final bool showMap;

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<MyAppColors>()!;
    final textTheme = Theme.of(context).textTheme;

    MapController mapController = MapController();

    void arrive() {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(
            Strings.of(context)!.arrive,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          content: Text(
            'pastikan anda sudah bertemu dengan pelanggan',
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
                context.read<OrderCubit>().arrive(params);
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              Strings.of(context)!.distance,
              style: textTheme.bodyMedium,
            ),
            SpacerH(
              value: Dimens.space24,
            ),
            Expanded(
              child: Text(
                '${toKiloMeter(direction.routes![0].distance!)} km',
                style:
                    textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                maxLines: 3,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              Strings.of(context)!.estimatedTime,
              style: textTheme.bodyMedium,
            ),
            SpacerH(
              value: Dimens.space24,
            ),
            Expanded(
              child: Text(
                '${toMinute(direction.routes![0].duration!)} menit',
                style:
                    textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                maxLines: 3,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        SpacerV(value: Dimens.space12),
        if (showMap)
          SizedBox(
            height: mapHeight,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                      minZoom: 13,
                      maxZoom: 18,
                      initialZoom: 15,
                      initialCenter:
                          context.read<LocationCubit>().currentLocation!,
                      keepAlive: true,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://api.mapbox.com/styles/v1/levelsekawan/{mapStyleId}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}',
                        additionalOptions: const {
                          'mapStyleId': ListAPI.streetStyle,
                          'accessToken': ListAPI.mapBoxAccessToken,
                        },
                      ),
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: direction.routes![0].geometry!.coordinates!,
                            strokeWidth: 5,
                            color: colorTheme.blue!,
                          ),
                        ],
                      ),
                      BlocBuilder<LocationCubit, LocationState>(
                        builder: (_, __) {
                          return MarkerLayer(
                            markers: [
                              Marker(
                                point: repairOrder.clientLocation!,
                                child: ProfilePicture(
                                  pictureUrl: context
                                      .read<ClientCubit>()
                                      .clients
                                      .firstWhere((element) =>
                                          element.uid == repairOrder.clientUid)
                                      .profilePicture!,
                                  onTap: () {},
                                  radius: Dimens.space12,
                                  border: Dimens.space2,
                                ),
                              ),
                              Marker(
                                point: context
                                    .read<LocationCubit>()
                                    .currentLocation!,
                                child: ProfilePicture(
                                  pictureUrl: context
                                      .read<AuthCubit>()
                                      .authUser!
                                      .profilePicture!,
                                  onTap: () {},
                                  radius: Dimens.space12,
                                  border: Dimens.space2,
                                ),
                              ),
                            ],
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        SpacerV(value: Dimens.space16),
        BlocBuilder<LocationCubit, LocationState>(
          builder: (_, __) {
            return FilledButton(
              onPressed: Geolocator.distanceBetween(
                        context.read<LocationCubit>().currentLocation!.latitude,
                        context
                            .read<LocationCubit>()
                            .currentLocation!
                            .longitude,
                        repairOrder.clientLocation!.latitude,
                        repairOrder.clientLocation!.longitude,
                      ) <=
                      100
                  ? arrive
                  : null,
              style: FilledButton.styleFrom(
                foregroundColor: Palette.background,
                minimumSize: Size(428.w, 40.w),
              ),
              child: Text(Strings.of(context)!.arrive),
            );
          },
        ),
      ],
    );
  }
}
