import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eazy/core/routing/app_router.dart';
import 'package:eazy/eazy.dart';

import 'features/authscreen/data/datasources/auth_remote_datasource.dart';
import 'features/authscreen/data/repositories/auth_repository_impl.dart';
import 'features/authscreen/domain/usecases/update_password_usecase.dart';
import 'features/authscreen/presentation/cubit/update_password_cubit.dart';
import 'features/profile/presentation/presentation/profilecubit/profile_cubit.dart';
import 'features/profile/presentation/presentation/services/profile_services.dart';

import 'package:dio/dio.dart';

void main() {
  final dio = Dio();
  final authRemoteDataSource = AuthRemoteDataSourceImpl(dio);
  final authRepository = AuthRepositoryImpl(remoteDataSource: authRemoteDataSource);

  final updatePasswordUseCase = UpdatePasswordUseCase(authRepository);

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ProfileCubit(ProfileService())..getProfile(),
          ),
          BlocProvider(
            create: (context) => UpdatePasswordCubit(updatePasswordUseCase),
          ),
        ],
        child: Eazy(appRouter: AppRouter()),
      ),
    ),
  );
}