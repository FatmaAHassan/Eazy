import 'package:eazy/features/home/Data/data_source/home_remote_datasource.dart';
import 'package:eazy/features/home/Data/model/home_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ---------- States ----------
abstract class HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final HomeData homeData;
  HomeLoaded(this.homeData);
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}

// ---------- Cubit ----------
// class HomeCubit extends Cubit<HomeState> {
//   final HomeRemoteDataSource dataSource;

//   HomeCubit(this.dataSource) : super(HomeLoading());

//   Future<void> fetchHomeData() async {
//     try {
//       final data = await dataSource.fetchHomeData();
//       emit(HomeLoaded(data));
//     } catch (e) {
//       emit(HomeError(e.toString()));
//     }
//   }
// }


class HomeCubit extends Cubit<HomeState> {
  final HomeRemoteDataSource dataSource;

  HomeCubit(this.dataSource) : super(HomeLoading());

  void fetchHomeData() async {
    try {
      final data = await dataSource.fetchHomeData();
      emit(HomeLoaded(data));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
