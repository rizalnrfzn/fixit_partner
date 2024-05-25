import 'package:cached_network_image/cached_network_image.dart';
import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';
import 'package:fixit_partner/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late GlobalKey<FormState> _keyForm;

  // controller
  late TextEditingController _conName;
  late TextEditingController _conEmail;
  late TextEditingController _conNumberPhone;
  late TextEditingController _conDescription;
  late TextEditingController _conAddress;

  // focus node
  late FocusNode _fnName;
  late FocusNode _fnEmail;
  late FocusNode _fnNumberPhone;
  late FocusNode _fnDescription;
  late FocusNode _fnAddress;

  List<String> selectedElectronics = [];

  late MapController mapController;

  late LatLng location;

  @override
  void initState() {
    final userData = context.read<AuthCubit>().authUser!;

    context.read<EditProfileCubit>().openPage(userData);

    _keyForm = GlobalKey<FormState>();
    _conName = TextEditingController(text: userData.name);
    _conEmail = TextEditingController(text: userData.email);
    _conNumberPhone = TextEditingController(text: userData.phoneNumber);
    _conDescription = TextEditingController(text: userData.description);
    _conAddress = TextEditingController(text: userData.address);

    _fnName = FocusNode();
    _fnEmail = FocusNode();
    _fnNumberPhone = FocusNode();
    _fnDescription = FocusNode();
    _fnAddress = FocusNode();

    selectedElectronics.addAll(userData.electronicId!);

    mapController = MapController();
    location = userData.location!;

    super.initState();
  }

  @override
  void dispose() {
    _keyForm.currentState?.dispose();
    _conName.dispose();
    _conEmail.dispose();
    _conNumberPhone.dispose();
    _conDescription.dispose();

    _fnName.dispose();
    _fnEmail.dispose();
    _fnNumberPhone.dispose();
    _fnDescription.dispose();

    mapController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).extension<MyAppColors>()!;

    return Parent(
      floatingButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: FilledButton(
          onPressed: () {
            /// Validate form first
            if (context.read<EditProfileCubit>().images.length >= 3) {
              if (_keyForm.currentState?.validate() ?? false) {
                context.read<AuthCubit>().editProfile(
                      EditProfileParams(
                        userData: context.read<AuthCubit>().authUser!.copyWith(
                              name: _conName.text,
                              phoneNumber: _conNumberPhone.text,
                              description: _conDescription.text,
                              address: _conAddress.text,
                              electronicId: selectedElectronics,
                            ),
                        newProfilePicture:
                            context.read<EditProfileCubit>().picture,
                        oldImages: context.read<EditProfileCubit>().oldImages,
                        newImages: context.read<EditProfileCubit>().newImages,
                      ),
                    );
              }
            } else {
              'minimal gambar harus 3'.toToastError(context);
            }
          },
          style: FilledButton.styleFrom(
            foregroundColor: Palette.background,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(Strings.of(context)!.saveChanges),
            ],
          ),
        ),
      ),
      appBar: MyAppBar(context, title: Strings.of(context)!.editProfile).call(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (_, state) {
          state.whenOrNull(
            loading: () => context.show(),
            successEditProfile: (data) {
              context.back();
              context.go(Routes.profile.path);
              // context.replace(Routes.profile.path);
            },
            failure: (message) {
              context.dismiss();

              message.toToastError(context);
            },
          );
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(Dimens.space24),
            child: Form(
              key: _keyForm,
              child: Column(
                children: [
                  Stack(
                    children: [
                      BlocBuilder<EditProfileCubit, EditProfileState>(
                        builder: (_, state) {
                          if (context.read<EditProfileCubit>().picture !=
                              null) {
                            return CircleAvatar(
                              radius: Dimens.space70,
                              backgroundColor: Theme.of(context).hintColor,
                              child: CircleAvatar(
                                radius: Dimens.space70 - Dimens.space4,
                                backgroundImage: FileImage(
                                    context.read<EditProfileCubit>().picture!),
                              ),
                            );
                          } else {
                            return ProfilePicture(
                              pictureUrl: context
                                  .read<AuthCubit>()
                                  .authUser!
                                  .profilePicture!,
                              onTap: () {},
                              radius: Dimens.space70,
                            );
                          }
                        },
                      ),
                      Positioned(
                        top: 110.w,
                        left: 100.w,
                        child: InkWell(
                          onTap: () {
                            context
                                .read<EditProfileCubit>()
                                .pickProfilePicture();
                          },
                          child: Container(
                            height: Dimens.space30,
                            width: Dimens.space30,
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .extension<MyAppColors>()!
                                  .blue,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: Dimens.space16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SpacerV(value: Dimens.space20),
                  TextF(
                    key: const Key('name'),
                    curFocusNode: _fnName,
                    nextFocusNode: _fnEmail,
                    textInputAction: TextInputAction.next,
                    controller: _conName,
                    keyboardType: TextInputType.name,
                    prefixIcon: Icon(
                      Icons.person,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                    hintText: Strings.of(context)!.name,
                    hint: Strings.of(context)!.name,
                    validator: (String? value) => value != ''
                        ? null
                        : Strings.of(context)!.errorEmptyField,
                  ),
                  TextF(
                    key: const Key('email'),
                    curFocusNode: _fnEmail,
                    nextFocusNode: _fnNumberPhone,
                    textInputAction: TextInputAction.next,
                    controller: _conEmail,
                    keyboardType: TextInputType.name,
                    readOnly: true,
                    prefixIcon: Icon(
                      Icons.email,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                    hintText: Strings.of(context)!.email,
                    hint: Strings.of(context)!.email,
                    validator: (String? value) => value != ''
                        ? null
                        : Strings.of(context)!.errorEmptyField,
                  ),
                  TextF(
                    key: const Key('number_phone'),
                    curFocusNode: _fnNumberPhone,
                    nextFocusNode: _fnDescription,
                    textInputAction: TextInputAction.next,
                    controller: _conNumberPhone,
                    keyboardType: TextInputType.phone,
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(13)
                    ],
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                    hintText: Strings.of(context)!.phoneNumber,
                    hint: Strings.of(context)!.phoneNumber,
                    validator: (String? value) => value != null
                        ? (value.length < 10
                            ? Strings.of(context)!.errorInvalidPhoneNumber
                            : null)
                        : null,
                  ),
                  TextF(
                    key: const Key('description'),
                    curFocusNode: _fnDescription,
                    nextFocusNode: _fnAddress,
                    textInputAction: TextInputAction.next,
                    controller: _conDescription,
                    keyboardType: TextInputType.text,
                    prefixIcon: Icon(
                      Icons.info,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                    hintText: Strings.of(context)!.name,
                    hint: Strings.of(context)!.name,
                    validator: (String? value) => value != ''
                        ? null
                        : Strings.of(context)!.errorEmptyField,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Text(
                          'Elektronik yang dikuasai',
                          style: textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<ElectronicCubit, ElectronicState>(
                    builder: (_, state) {
                      return state.maybeWhen(
                        orElse: () => const Center(child: Loading()),
                        stream: (electronics) {
                          List<Electronic> allElectronics = [];
                          allElectronics.addAll(electronics);
                          allElectronics.removeWhere((element) =>
                              element.id == 'wzicVyX1YzsQfn9cmAaq');
                          return Wrap(
                            spacing: Dimens.space6,
                            children: List.generate(
                              allElectronics.length,
                              (index) => FilterChip(
                                label: Text(
                                  allElectronics[index].name!,
                                  style: textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: selectedElectronics
                                            .contains(allElectronics[index].id)
                                        ? colorTheme.background
                                        : colorTheme.blue,
                                  ),
                                ),
                                showCheckmark: false,
                                selected: selectedElectronics
                                    .contains(allElectronics[index].id),
                                selectedColor: colorTheme.blue,
                                checkmarkColor: Palette.background,
                                side: BorderSide(color: colorTheme.blue!),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                onSelected: (value) {
                                  setState(() {
                                    if (value) {
                                      selectedElectronics
                                          .add(allElectronics[index].id!);
                                    } else {
                                      selectedElectronics.removeWhere(
                                          (element) =>
                                              element ==
                                              allElectronics[index].id);
                                    }
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SpacerV(value: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Text(
                          'Lokasi',
                          style: textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 350,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FlutterMap(
                        mapController: mapController,
                        options: MapOptions(
                          minZoom: 13,
                          maxZoom: 18,
                          initialZoom: 14,
                          initialCenter: location,
                          keepAlive: true,
                          onTap: (_, point) {},
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
                                point: location,
                                child: Icon(
                                  Icons.location_on,
                                  color: colorTheme.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  TextF(
                    key: const Key('address'),
                    curFocusNode: _fnAddress,
                    textInputAction: TextInputAction.next,
                    controller: _conAddress,
                    keyboardType: TextInputType.text,
                    prefixIcon: Icon(
                      Icons.location_on,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                    hintText: Strings.of(context)!.name,
                    hint: Strings.of(context)!.name,
                    validator: (String? value) => value != ''
                        ? null
                        : Strings.of(context)!.errorEmptyField,
                  ),
                  BlocBuilder<EditProfileCubit, EditProfileState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: Row(
                              children: [
                                Text(
                                  'Foto',
                                  style: textTheme.bodyLarge!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  Strings.of(context)!.optional,
                                  style: textTheme.bodySmall,
                                ),
                                const Expanded(child: SizedBox()),
                                IconButton(
                                  onPressed: () {
                                    context
                                        .read<EditProfileCubit>()
                                        .pickImages();
                                  },
                                  icon: const Icon(Icons.add_photo_alternate),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: Dimens.space8),
                            padding: EdgeInsets.all(Dimens.space8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              color:
                                  Theme.of(context).hintColor.withOpacity(0.3),
                            ),
                            child: StaggeredGrid.count(
                              crossAxisCount: context
                                          .read<EditProfileCubit>()
                                          .images
                                          .length >
                                      2
                                  ? 2
                                  : 1,
                              crossAxisSpacing: Dimens.space8,
                              mainAxisSpacing: Dimens.space8,
                              children: List.generate(
                                context.read<EditProfileCubit>().images.length,
                                (index) => StaggeredGridTile.fit(
                                  crossAxisCellCount: 1,
                                  child: Stack(
                                    children: [
                                      InkWell(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        onTap: () {
                                          showAdaptiveDialog(
                                            context: context,
                                            builder: (_) => ImageDialog(
                                              image: context
                                                  .read<EditProfileCubit>()
                                                  .images[index],
                                            ),
                                          );
                                        },
                                        child: context
                                                .read<EditProfileCubit>()
                                                .images[index] is String
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20.r),
                                                child: SizedBox(
                                                  child: CachedNetworkImage(
                                                    imageUrl: context
                                                        .read<
                                                            EditProfileCubit>()
                                                        .images[index],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20.r),
                                                child: SizedBox(
                                                  child: Image.file(
                                                    context
                                                        .read<
                                                            EditProfileCubit>()
                                                        .images[index],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          context
                                              .read<EditProfileCubit>()
                                              .removeImages(index);
                                        },
                                        icon: const Icon(Icons.close),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  SpacerV(value: Dimens.space46),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
