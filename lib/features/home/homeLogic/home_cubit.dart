import 'package:final_proj/core/models/home_service.dart';
import 'package:final_proj/core/models/restaurant_model.dart';
import 'package:final_proj/core/network/ApiResult.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class HomeState {}
class HomeLoading extends HomeState {}
class HomeLoaded extends HomeState {
  final List<RestaurantModel> fastest;
  final List<RestaurantModel> recommended;
  HomeLoaded({required this.fastest, required this.recommended});
}
class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}

class HomeCubit extends Cubit<HomeState> {
  final HomeService _homeService = HomeService();
  HomeCubit() : super(HomeLoading());

  Future<void> fetchHomeData() async {
    emit(HomeLoading());
    final result = await _homeService.getRestaurants();

    if (result is Success<List<RestaurantModel>>) {
      final allData = result.data!;
      final fastest = allData.where((r) => r.category == 'fastest').toList();
      final recommended = allData.where((r) => r.category == 'recommended').toList();
      emit(HomeLoaded(fastest: fastest, recommended: recommended));
    } else if (result is Failure) {
      emit(HomeError((result as Failure).exception.errorMessage));
    }
  }
}