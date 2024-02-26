import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';
import 'package:fixit_partner/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<MyAppColors>()!;

    MapController mapController = MapController();

    List<String> notOrderStatus = [
      Status.beriUlasan.name,
      Status.pesananSelesai.name,
    ];

    return Parent(
      child: RefreshIndicator(
        color: Theme.of(context).extension<MyAppColors>()!.blue,
        backgroundColor: Theme.of(context).extension<MyAppColors>()!.background,
        onRefresh: () async {
          context.read<ElectronicCubit>().streamElectronics();
          context.read<AuthCubit>().streamUser(
              MainBoxMixin.mainBox!.get(MainBoxKeys.authUserId.name));
          context.read<ChatCubit>().streamChatList(
              MainBoxMixin.mainBox!.get(MainBoxKeys.authUserId.name));
        },
        child: SafeArea(
          child: BlocBuilder<OrderCubit, OrderState>(
            builder: (context, state) {
              if (context.read<LocationCubit>().currentLocation == null) {
                context.read<LocationCubit>().streamLocation();
              }
              return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (context.read<OrderCubit>().orders.isNotEmpty) {
                    if (context.read<AuthCubit>().authUser!.inOrder!) {
                      context.read<LocationCubit>().getDirection(context
                          .read<OrderCubit>()
                          .orders
                          .firstWhere((element) =>
                              !(notOrderStatus.contains(element.status)))
                          .clientLocation!);
                    }
                  }

                  return BlocBuilder<LocationCubit, LocationState>(
                    builder: (context, state) {
                      return state.when(
                        initial: () => const Center(
                          child: Loading(),
                        ),
                        failure: (message) => Empty(errorMessage: message),
                        success: (geolocation, direction, currentLocation) {
                          return Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              FlutterMap(
                                mapController: mapController,
                                options: MapOptions(
                                  minZoom: 13,
                                  maxZoom: 20,
                                  initialCenter: context
                                      .read<LocationCubit>()
                                      .currentLocation!,
                                  initialZoom: 17,
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
                                  MarkerLayer(
                                    markers: [
                                      Marker(
                                        point: context
                                            .read<LocationCubit>()
                                            .currentLocation!,
                                        child: Icon(
                                          Icons.my_location,
                                          color: colorTheme.red,
                                        ),
                                      ),
                                      if (context
                                          .read<AuthCubit>()
                                          .authUser!
                                          .inOrder!)
                                        Marker(
                                          point: context
                                              .read<OrderCubit>()
                                              .orders
                                              .firstWhere((element) =>
                                                  !(notOrderStatus.contains(
                                                      element.status)))
                                              .clientLocation!,
                                          child: ProfilePicture(
                                            pictureUrl: context
                                                .read<ClientCubit>()
                                                .clients
                                                .firstWhere(
                                                  (element) =>
                                                      element.uid ==
                                                      context
                                                          .read<OrderCubit>()
                                                          .orders
                                                          .firstWhere(
                                                            (element) =>
                                                                !(notOrderStatus
                                                                    .contains(
                                                                        element
                                                                            .status)),
                                                          )
                                                          .clientUid,
                                                )
                                                .profilePicture!,
                                            onTap: () {},
                                            radius: Dimens.space12,
                                            border: Dimens.space2,
                                          ),
                                        ),
                                    ],
                                  ),
                                  if (context
                                      .read<AuthCubit>()
                                      .authUser!
                                      .inOrder!)
                                    if (context
                                            .read<LocationCubit>()
                                            .direction !=
                                        null)
                                      BlocBuilder<LocationCubit, LocationState>(
                                        builder: (context, state) {
                                          return PolylineLayer(
                                            polylines: [
                                              Polyline(
                                                points: context
                                                    .read<LocationCubit>()
                                                    .direction!
                                                    .routes![0]
                                                    .geometry!
                                                    .coordinates!,
                                                strokeWidth: 5,
                                                color: colorTheme.blue!,
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                ],
                              ),
                              Positioned(
                                top: Dimens.space16,
                                child: SizedBox(
                                  width: 380.w,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          mapController.move(
                                              context
                                                  .read<LocationCubit>()
                                                  .currentLocation!,
                                              17);
                                        },
                                        child: Container(
                                          padding:
                                              EdgeInsets.all(Dimens.space8),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: colorTheme.card,
                                          ),
                                          child: Icon(Icons.my_location),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: colorTheme.card,
                                              borderRadius:
                                                  BorderRadius.horizontal(
                                                left: Radius.circular(20.r),
                                              ),
                                            ),
                                            padding: EdgeInsets.all(10.w),
                                            child: context
                                                    .read<AuthCubit>()
                                                    .authUser!
                                                    .isOnline!
                                                ? Text('Online')
                                                : Text('Offline'),
                                          ),
                                          SpacerH(value: Dimens.space4),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: colorTheme.card,
                                              borderRadius:
                                                  BorderRadius.horizontal(
                                                right: Radius.circular(20.r),
                                              ),
                                            ),
                                            padding: EdgeInsets.all(10.w),
                                            child: context
                                                    .read<AuthCubit>()
                                                    .authUser!
                                                    .isOnline!
                                                ? Text('Online')
                                                : Text('Offline'),
                                          ),
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          context.read<AuthCubit>().online(
                                              context
                                                  .read<AuthCubit>()
                                                  .authUser!);
                                        },
                                        child: Container(
                                          padding:
                                              EdgeInsets.all(Dimens.space8),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: colorTheme.card,
                                          ),
                                          child: Icon(Icons.power_settings_new),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (context.read<AuthCubit>().authUser!.inOrder!)
                                BlocBuilder<OrderCubit, OrderState>(
                                  builder: (context, state) {
                                    return Positioned(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Dimens.space24),
                                        child: ListView(
                                          reverse: true,
                                          shrinkWrap: true,
                                          children: [
                                            BlocProvider(
                                              create: (context) =>
                                                  sl<OrderTileCubit>(),
                                              child: SingleChildScrollView(
                                                child: Row(
                                                  children: [
                                                    OrderListTile(
                                                      repairOrder: context
                                                          .read<OrderCubit>()
                                                          .orders
                                                          .firstWhere(
                                                            (element) =>
                                                                !(notOrderStatus
                                                                    .contains(
                                                                        element
                                                                            .status)),
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
