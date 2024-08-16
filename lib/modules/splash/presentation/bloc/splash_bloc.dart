import 'dart:convert';

import 'package:energy_park/constants/app_constants.dart';
import 'package:energy_park/modules/splash/data/model/failure_response_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SignInEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<GetAppInitialData>(_onGetAppInitialData);
  }

  Future<void> _onGetAppInitialData(
    GetAppInitialData event,
    Emitter<SplashState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 2));
    emit(NavigateToHome());
  }
}
