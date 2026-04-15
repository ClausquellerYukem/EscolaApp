// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/datasources/auth_remote_datasource.dart'
    as _i161;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/login_usecase.dart' as _i188;
import '../../features/auth/presentation/bloc/auth_bloc.dart' as _i797;
import '../../features/students/data/repositories/student_repository_impl.dart'
    as _i865;
import '../../features/students/domain/repositories/student_repository.dart'
    as _i679;
import '../../features/students/domain/usecases/get_students_by_guardian_usecase.dart'
    as _i144;
import '../../features/students/presentation/bloc/student_session_cubit.dart'
    as _i841;
import '../api/api_client.dart' as _i277;
import '../api/auth_interceptor.dart' as _i577;
import '../api/tenant_interceptor.dart' as _i994;
import '../security/session_manager.dart' as _i415;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.singleton<_i558.FlutterSecureStorage>(
        () => registerModule.secureStorage);
    gh.singleton<_i361.Dio>(() => registerModule.dio);
    gh.singleton<_i841.StudentSessionCubit>(() => _i841.StudentSessionCubit());
    gh.factory<_i679.StudentRepository>(() => _i865.StudentRepositoryImpl());
    gh.factory<_i161.AuthRemoteDataSource>(
        () => _i161.AuthRemoteDataSource(gh<_i361.Dio>()));
    gh.factory<_i144.GetStudentsByGuardianUseCase>(() =>
        _i144.GetStudentsByGuardianUseCase(gh<_i679.StudentRepository>()));
    gh.factory<_i994.TenantInterceptor>(
        () => _i994.TenantInterceptor(gh<_i558.FlutterSecureStorage>()));
    gh.singleton<_i415.SessionManager>(
        () => _i415.SessionManager(gh<_i558.FlutterSecureStorage>()));
    gh.factory<_i787.AuthRepository>(() => _i153.AuthRepositoryImpl(
          gh<_i161.AuthRemoteDataSource>(),
          gh<_i415.SessionManager>(),
        ));
    gh.factory<_i577.AuthInterceptor>(
        () => _i577.AuthInterceptor(gh<_i415.SessionManager>()));
    gh.factory<_i188.LoginUseCase>(
        () => _i188.LoginUseCase(gh<_i787.AuthRepository>()));
    gh.singleton<_i277.ApiClient>(() => _i277.ApiClient(
          gh<_i361.Dio>(),
          gh<_i577.AuthInterceptor>(),
          gh<_i994.TenantInterceptor>(),
        ));
    gh.factory<_i797.AuthBloc>(() => _i797.AuthBloc(gh<_i188.LoginUseCase>()));
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}
