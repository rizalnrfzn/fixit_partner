import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/data/repositories/review_repository_impl.dart';
import 'package:fixit_partner/features/domain/repositories/review_repository.dart';
import 'package:fixit_partner/features/domain/usecases/stream_review_usecase.dart';
import 'package:fixit_partner/features/features.dart';
import 'package:fixit_partner/features/presentation/pages/profile/review/cubit/review_cubit.dart';
import 'package:fixit_partner/utils/utils.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

Future<void> serviceLocator({
  bool isUnitTest = false,
  bool isHiveEnable = true,
  String prefixBox = '',
}) async {
  /// For unit testing only
  if (isUnitTest) {
    await sl.reset();
  }
  sl.registerSingleton<DioClient>(DioClient(isUnitTest: isUnitTest));
  _dataSources();
  _repositories();
  _useCase();
  _cubit();
  if (isHiveEnable) {
    await _initHiveBoxes(
      isUnitTest: isUnitTest,
      prefixBox: prefixBox,
    );
  }
}

Future<void> _initHiveBoxes({
  bool isUnitTest = false,
  String prefixBox = '',
}) async {
  await MainBoxMixin.initHive(prefixBox);
  sl.registerSingleton<MainBoxMixin>(MainBoxMixin());
}

/// Register repositories
void _repositories() {
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl(), sl()));

  sl.registerLazySingleton<DirectionRepository>(
      () => DirectionRepositoryImpl(sl()));

  sl.registerLazySingleton<ElectronicRepository>(
      () => ElectronicRepositoryImpl(sl()));

  sl.registerLazySingleton<GeolocationRepository>(
      () => GeolocationRepositoryImpl(sl()));

  sl.registerLazySingleton<RepairOrderRepository>(
      () => RepairOrderRepositoryImpl(sl()));

  sl.registerLazySingleton<ClientRepository>(() => ClientRepositoryImpl(sl()));

  sl.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(sl()));

  sl.registerLazySingleton<ReviewRepository>(() => ReviewRepositoryImpl(sl()));
}

/// Register dataSources
void _dataSources() {
  sl.registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl());

  sl.registerLazySingleton<DirectionRemoteDatasource>(
      () => DirectionRemoteDatasourceImpl(sl()));

  sl.registerLazySingleton<ElectronicRemoteDatasource>(
      () => ElectronicRemoteDatasourceImpl());

  sl.registerLazySingleton<GeolocationRemoteDatasource>(
      () => GeolocationRemoteDatasourceImpl());

  sl.registerLazySingleton<RepairOrderRemoteDatasource>(
      () => RepairOrderRemoteDatasourceImpl());

  sl.registerLazySingleton<ClientRemoteDatasource>(
      () => ClientRemoteDatasourceImpl());

  sl.registerLazySingleton<ChatRemoteDatasource>(
      () => ChatRemoteDatasourceImpl());

  sl.registerLazySingleton<ReviewRemoteDatasource>(
      () => ReviewRemoteDatasourceImpl());
}

void _useCase() {
  /// Auth
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => StreamAuthUserUsecase(sl()));
  sl.registerLazySingleton(() => RegisterUsecase(sl()));
  sl.registerLazySingleton(() => RegisterDataUsecase(sl()));
  sl.registerLazySingleton(() => EditProfileUsecase(sl()));
  sl.registerLazySingleton(() => OnlineUsecase(sl()));

  /// technician
  sl.registerLazySingleton(() => GetDirectionUsecase(sl()));
  sl.registerLazySingleton(() => StreamReviewUsecase(sl()));

  // order
  sl.registerLazySingleton(() => StreamRepairOrdersUsecase(sl()));
  sl.registerLazySingleton(() => PostOrderUsecase(sl()));
  sl.registerLazySingleton(() => AcceptOrderUsecase(sl()));
  sl.registerLazySingleton(() => RejectOrderUsecase(sl()));
  sl.registerLazySingleton(() => ArriveUsecase(sl()));
  sl.registerLazySingleton(() => CheckingElectronicUsecase(sl()));
  sl.registerLazySingleton(() => ElectronicRepairUsecase(sl()));
  sl.registerLazySingleton(() => PaymentConfirmationUsecase(sl()));

  // electronic
  sl.registerLazySingleton(() => StreamElectronicsUsecase(sl()));

  // client
  sl.registerLazySingleton(() => GetClientUsecase(sl()));
  sl.registerLazySingleton(() => GetClientsUsecase(sl()));

  // location
  sl.registerLazySingleton(() => GetLocationUsecase(sl()));
  sl.registerLazySingleton(() => ChangeLocationUsecase(sl()));
  sl.registerLazySingleton(() => StreamLocation(sl()));
  sl.registerLazySingleton(() => UpdateLocationUsecse(sl()));

  // chat
  sl.registerLazySingleton(() => StreamChatUsecase(sl()));
  sl.registerLazySingleton(() => StreamChatListUsecase(sl()));
  sl.registerLazySingleton(() => GetChatUsecase(sl()));
  sl.registerLazySingleton(() => PostChatUsecase(sl()));
  sl.registerLazySingleton(() => ReadChatUsecase(sl()));
}

void _cubit() {
  // cubit
  sl.registerFactory(() => AuthCubit(sl(), sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory(() => ElectronicCubit(sl()));
  sl.registerFactory(
      () => OrderCubit(sl(), sl(), sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory(() => LocationCubit(sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory(() => ChatCubit(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => ClientCubit(sl()));

  /// general pages
  sl.registerFactory(() => SettingsCubit());
  sl.registerFactory(() => MainCubit());

  /// profile
  sl.registerFactory(() => EditProfileCubit());
  sl.registerFactory(() => ReviewCubit(sl(), sl()));

  /// Auth pages
  sl.registerFactory(() => LoginCubit());
  sl.registerFactory(() => RegisterCubit());
  sl.registerFactory(() => RegisterDataCubit());

  // Order
  sl.registerFactory(() => OrderDetailCubit(sl()));
  sl.registerFactory(() => OrderTileCubit(sl()));
}
