part of 'init_dependencies.dart';
final servicelocater = GetIt.instance;
// INCORRECT
Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  // 1. Initialize Supabase
  final supabase = await Supabase.initialize(
    url: SupabaseSecrets.superbaseUrl,
    anonKey: SupabaseSecrets.superbaseAnonKey,
  );


  servicelocater.registerLazySingleton(() => supabase.client);

  servicelocater.registerLazySingleton(()=> Hive.box('blogs'));

  servicelocater.registerFactory(() => InternetConnection());

  //core
  servicelocater.registerLazySingleton(() => AppUserCubit());

  servicelocater.registerFactory<ConnectionChecker>(
        () => ConnectionCheckerImpl(servicelocater()),
  );
}

void _initAuth() {
  servicelocater
    ..registerFactory<AuthDataSource>(
          () => AuthDataSourceImpl(servicelocater()),
    )
    ..registerFactory<AuthRepository>(
          () => AuthRepositoryImpl(servicelocater(), servicelocater()),
    )
    ..registerFactory(() => UserSignup(servicelocater()))
    ..registerFactory(() => UserLogin(servicelocater()))
    ..registerFactory(() => CurrentUser(servicelocater()))
   ..registerFactory(()=> UserLogOut(servicelocater()))
    ..registerLazySingleton(
          () => AuthBloc(
        userSignup: servicelocater(),
        userLogin: servicelocater(),
        currentUser: servicelocater(),
        appUserCubit: servicelocater(),
        userLogOut:  servicelocater(),
      ),
    );
}

void _initBlog() {
  servicelocater
    ..registerFactory<BlogDataSource>(
          () => BlogDaraSourceImpl(servicelocater()),
    )
    ..registerFactory<BlogLocalDataSource>(()=> BlogLocalDataSourceImpl(servicelocater()))
    ..registerFactory<BlogRepository>(
          () => BlogRepositoryImpl(servicelocater(), servicelocater(),servicelocater()),
    )
    ..registerFactory(() => UploadBlog(servicelocater()))
    ..registerFactory(() => GetAllBlogs(servicelocater()))
    ..registerLazySingleton(
          () =>
          BlogBloc(uploadBlog: servicelocater(), getAllBlogs: servicelocater()),
    );
}
