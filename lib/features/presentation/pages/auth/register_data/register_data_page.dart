import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';
import 'package:fixit_partner/utils/ext/context.dart';
import 'package:fixit_partner/utils/ext/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';

class RegisterDataPage extends StatefulWidget {
  const RegisterDataPage({super.key});

  @override
  State<RegisterDataPage> createState() => _RegisterDataPageState();
}

class _RegisterDataPageState extends State<RegisterDataPage> {
  late GlobalKey<FormState> _keyForm;

  // controller
  late TextEditingController _conName;
  late TextEditingController _conNumberPhone;
  late TextEditingController _conDescription;
  late TextEditingController _conAddress;

  // focus node
  late FocusNode _fnName;
  late FocusNode _fnNumberPhone;
  late FocusNode _fnDescription;

  List<String> selectedElectronics = [];

  final MapController mapController = MapController();

  @override
  void initState() {
    _keyForm = GlobalKey<FormState>();
    _conName = TextEditingController();
    _conNumberPhone = TextEditingController();
    _conDescription = TextEditingController();
    _conAddress = TextEditingController();
    _fnName = FocusNode();
    _fnNumberPhone = FocusNode();
    _fnDescription = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _keyForm.currentState?.dispose();
    _conName.dispose();
    _conNumberPhone.dispose();
    _conDescription.dispose();
    _conAddress.dispose();
    _fnName.dispose();
    _fnNumberPhone.dispose();
    _fnDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).extension<MyAppColors>()!;

    return Parent(
      appBar: MyAppBar(
        context,
        title: Strings.of(context)!.fillYourProfile,
        action: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text(
                  Strings.of(context)!.logout,
                  style: textTheme.bodyLarge,
                ),
                content: Text(
                  Strings.of(context)!.logoutDesc,
                  style: textTheme.bodyMedium,
                ),
                actions: [
                  TextButton(
                    onPressed: () => context.back(),
                    child: Text(
                      Strings.of(context)!.cancel,
                      style: textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context)
                            .extension<MyAppColors>()!
                            .subtitle,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<AuthCubit>().logout();
                    },
                    child: Text(
                      Strings.of(context)!.yes,
                      style: textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).extension<MyAppColors>()!.blue,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          icon: const Icon(Icons.logout),
        ),
      ).call(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (_, state) {
          state.whenOrNull(
            loading: () => context.show(),
            successRegisterData: (data) {
              context.dismiss();
              context.go(Routes.waitingVerification.path);
            },
            logedOut: () {
              context.go(Routes.login.path);
            },
            failure: (message) {
              context.dismiss();

              message.toToastError(context);
            },
          );
        },
        child: BlocBuilder<RegisterDataCubit, RegisterDataState>(
          builder: (_, state) {
            return Stepper(
              controlsBuilder: (context, details) =>
                  SizedBox(width: MediaQuery.of(context).size.width * 0.8),
              currentStep: context.read<RegisterDataCubit>().index,
              type: StepperType.horizontal,
              steps: [
                Step(
                  title: const Text('Data Diri'),
                  isActive: context.read<RegisterDataCubit>().index >= 0,
                  content: Form(
                    key: _keyForm,
                    child: Column(
                      children: [
                        SpacerH(
                          value: Dimens.space16,
                        ),
                        TextF(
                          key: const Key('name'),
                          curFocusNode: _fnName,
                          nextFocusNode: _fnNumberPhone,
                          textInputAction: TextInputAction.next,
                          controller: _conName,
                          keyboardType: TextInputType.name,
                          prefixIcon: Icon(
                            Icons.person,
                            color: textTheme.bodyLarge?.color,
                          ),
                          hintText: Strings.of(context)!.name,
                          hint: Strings.of(context)!.name,
                          validator: (String? value) => value != ''
                              ? null
                              : Strings.of(context)!.errorEmptyField,
                        ),
                        TextF(
                          key: const Key('number_phone'),
                          curFocusNode: _fnNumberPhone,
                          textInputAction: TextInputAction.next,
                          controller: _conNumberPhone,
                          keyboardType: TextInputType.phone,
                          inputFormatter: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(13)
                          ],
                          prefixIcon: Icon(
                            Icons.phone,
                            color: textTheme.bodyLarge?.color,
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
                          textInputAction: TextInputAction.next,
                          controller: _conDescription,
                          keyboardType: TextInputType.name,
                          maxLine: null,
                          prefixIcon: Icon(
                            Icons.person,
                            color: textTheme.bodyLarge?.color,
                          ),
                          hintText: 'Deskripsi',
                          hint: 'Deskripsi',
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
                                          color: selectedElectronics.contains(
                                                  allElectronics[index].id)
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
                        SpacerV(value: Dimens.space16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: Dimens.space24),
                            FilledButton(
                              onPressed: () {
                                if (_keyForm.currentState?.validate() ??
                                    false) {
                                  if (selectedElectronics.length < 3) {
                                    'Harus menguasai minimal 3 elekrronik'
                                        .toToastError(context);
                                  } else {
                                    context.read<LocationCubit>().getLocation();
                                    context
                                        .read<RegisterDataCubit>()
                                        .nextStep();
                                  }
                                }
                              },
                              child: Text(Strings.of(context)!.next),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Step(
                  title: const Text('Lokasi'),
                  isActive: context.read<RegisterDataCubit>().index >= 1,
                  content: BlocBuilder<LocationCubit, LocationState>(
                    builder: (_, state) {
                      return state.when(
                        initial: () => const Center(
                          child: Loading(),
                        ),
                        failure: (message) => Center(
                          child: Empty(errorMessage: message),
                        ),
                        success: (geolocation, direction, currentLocation) {
                          _conAddress.text = geolocation!.placemark!.name ==
                                  geolocation.placemark!.street
                              ? '${geolocation.placemark!.subLocality}, ${geolocation.placemark!.locality}'
                              : '${geolocation.placemark!.street}, ${geolocation.placemark!.subLocality}, ${geolocation.placemark!.locality}';
                          return Column(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 550.h,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: FlutterMap(
                                        mapController: mapController,
                                        options: MapOptions(
                                          minZoom: 13,
                                          maxZoom: 18,
                                          initialZoom: 14,
                                          initialCenter: geolocation.location!,
                                          keepAlive: true,
                                          onTap: (_, point) {
                                            context
                                                .read<LocationCubit>()
                                                .changeCurrentLocation(point);
                                          },
                                        ),
                                        children: [
                                          TileLayer(
                                            urlTemplate:
                                                'https://api.mapbox.com/styles/v1/levelsekawan/{mapStyleId}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}',
                                            additionalOptions: const {
                                              'mapStyleId': ListAPI.streetStyle,
                                              'accessToken':
                                                  ListAPI.mapBoxAccessToken,
                                            },
                                          ),
                                          MarkerLayer(
                                            markers: [
                                              Marker(
                                                point: geolocation.location!,
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
                                    autofillHints: const [AutofillHints.email],
                                    key: const Key("address"),
                                    textInputAction: TextInputAction.done,
                                    controller: _conAddress,
                                    keyboardType: TextInputType.emailAddress,
                                    readOnly: true,
                                    prefixIcon: Icon(
                                      Icons.home_outlined,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.color,
                                    ),
                                    hintText: Strings.of(context)!.address,
                                    hint: Strings.of(context)!.email,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ButtonText(
                                        title: Strings.of(context)!.back,
                                        onPressed: () {
                                          context
                                              .read<RegisterDataCubit>()
                                              .backStep();
                                        },
                                      ),
                                      SizedBox(width: Dimens.space24),
                                      FilledButton(
                                        onPressed: () {
                                          context
                                              .read<RegisterDataCubit>()
                                              .nextStep();
                                        },
                                        child: Text(Strings.of(context)!.next),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
                Step(
                  title: const Text('Berkas'),
                  isActive: context.read<RegisterDataCubit>().index >= 2,
                  content: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          context.read<RegisterDataCubit>().profilePicture ==
                                  null
                              ? ProfilePicture(
                                  pictureUrl: context
                                      .read<AuthCubit>()
                                      .authUser!
                                      .profilePicture,
                                  onTap: () {},
                                  radius: Dimens.space70,
                                )
                              : CircleAvatar(
                                  radius: Dimens.space70,
                                  backgroundColor: Theme.of(context).hintColor,
                                  child: CircleAvatar(
                                    radius: Dimens.space70 - Dimens.space4,
                                    backgroundImage: FileImage(context
                                        .read<RegisterDataCubit>()
                                        .profilePicture!),
                                  ),
                                ),
                          Positioned(
                            top: 110.w,
                            left: 100.w,
                            child: InkWell(
                              onTap: () {
                                context
                                    .read<RegisterDataCubit>()
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
                      Padding(
                        padding: EdgeInsets.all(Dimens.space12),
                        child: const Text('Foto Profil'),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: Row(
                              children: [
                                Text(
                                  'Foto terkait usaha servis elektronik Anda',
                                  style: textTheme.bodyLarge!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                const Expanded(child: SizedBox()),
                                IconButton(
                                  onPressed: () {
                                    context
                                        .read<RegisterDataCubit>()
                                        .pickImages();
                                  },
                                  icon: const Icon(Icons.add_photo_alternate),
                                ),
                              ],
                            ),
                          ),
                          if (context
                              .read<RegisterDataCubit>()
                              .images
                              .isNotEmpty)
                            Container(
                              margin: EdgeInsets.only(top: Dimens.space8),
                              padding: EdgeInsets.all(Dimens.space8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: Theme.of(context)
                                    .hintColor
                                    .withOpacity(0.3),
                              ),
                              child: StaggeredGrid.count(
                                crossAxisCount: context
                                            .read<RegisterDataCubit>()
                                            .images
                                            .length >
                                        2
                                    ? 2
                                    : context
                                        .read<RegisterDataCubit>()
                                        .images
                                        .length,
                                crossAxisSpacing: Dimens.space8,
                                mainAxisSpacing: Dimens.space8,
                                children: List.generate(
                                  context
                                      .read<RegisterDataCubit>()
                                      .images
                                      .length,
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
                                                    .read<RegisterDataCubit>()
                                                    .images[index],
                                              ),
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            child: SizedBox(
                                              child: Image.file(
                                                context
                                                    .read<RegisterDataCubit>()
                                                    .images[index],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            context
                                                .read<RegisterDataCubit>()
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
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black54),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Berkas terkait usaha\nServis Elektronik Anda',
                                    maxLines: 2,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context
                                          .read<RegisterDataCubit>()
                                          .pickFiles();
                                    },
                                    child: const Text('tambah'),
                                  ),
                                ],
                              ),
                              if (context
                                  .read<RegisterDataCubit>()
                                  .files
                                  .isNotEmpty)
                                Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.3),
                                  ),
                                  child: Column(
                                    children: List.generate(
                                      context
                                          .read<RegisterDataCubit>()
                                          .files
                                          .length,
                                      (index) => ListTile(
                                        leading: const Icon(Icons.file_copy),
                                        title: Text(
                                          basename(context
                                              .read<RegisterDataCubit>()
                                              .files[index]
                                              .path),
                                        ),
                                        trailing: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.close),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FilledButton(
                            onPressed: () {
                              if (context
                                      .read<RegisterDataCubit>()
                                      .images
                                      .length >=
                                  3) {
                                if (context
                                    .read<RegisterDataCubit>()
                                    .files
                                    .isNotEmpty) {
                                  final userData = context
                                      .read<AuthCubit>()
                                      .authUser!
                                      .copyWith(
                                        name: _conName.text,
                                        phoneNumber: _conNumberPhone.text,
                                        description: _conDescription.text,
                                        address: _conAddress.text,
                                        electronicId: selectedElectronics,
                                        location: context
                                            .read<LocationCubit>()
                                            .geolocation!
                                            .location,
                                        currentLocation: context
                                            .read<LocationCubit>()
                                            .geolocation!
                                            .location,
                                        isRegistered: true,
                                      );
                                  final profilePicture = context
                                      .read<RegisterDataCubit>()
                                      .profilePicture;
                                  final images =
                                      context.read<RegisterDataCubit>().images;
                                  final files =
                                      context.read<RegisterDataCubit>().files;
                                  context.push(
                                    Routes.registerDataSummary.path,
                                    extra: [
                                      userData,
                                      profilePicture,
                                      images,
                                      files
                                    ],
                                  );
                                } else {
                                  'Files must more than 1'
                                      .toToastError(context);
                                }
                              } else {
                                'Images must more than 3'.toToastError(context);
                              }
                            },
                            child: const Text('Preview'),
                          ),
                          const Spacer(),
                          ButtonText(
                            title: Strings.of(context)!.back,
                            onPressed: () {
                              context.read<RegisterDataCubit>().backStep();
                            },
                          ),
                          SizedBox(width: Dimens.space24),
                          FilledButton(
                            onPressed: () {
                              if (context
                                      .read<RegisterDataCubit>()
                                      .images
                                      .length >=
                                  3) {
                                if (context
                                    .read<RegisterDataCubit>()
                                    .files
                                    .isNotEmpty) {
                                  final userData = context
                                      .read<AuthCubit>()
                                      .authUser!
                                      .copyWith(
                                        name: _conName.text,
                                        phoneNumber: _conNumberPhone.text,
                                        description: _conDescription.text,
                                        address: _conAddress.text,
                                        electronicId: selectedElectronics,
                                        location: context
                                            .read<LocationCubit>()
                                            .geolocation!
                                            .location,
                                        isRegistered: true,
                                      );
                                  final profilePicture = context
                                      .read<RegisterDataCubit>()
                                      .profilePicture;
                                  final images =
                                      context.read<RegisterDataCubit>().images;
                                  final files =
                                      context.read<RegisterDataCubit>().files;

                                  context.read<AuthCubit>().registerData(
                                        RegisterDataParams(
                                            userData: userData,
                                            profilePicture: profilePicture,
                                            images: images,
                                            files: files),
                                      );
                                } else {
                                  'Files must more than 1'
                                      .toToastError(context);
                                }
                              } else {
                                'Images must more than 3'.toToastError(context);
                              }
                            },
                            child: Text(Strings.of(context)!.next),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
