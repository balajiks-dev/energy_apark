import 'package:flutter/cupertino.dart';
import 'package:energy_park/config/colors.dart';
import 'package:energy_park/config/widgets/common_snack_bar.dart';
import 'package:energy_park/config/widgets/custom_progress_bar.dart';
import 'package:energy_park/constants/assets_path.dart';
import 'package:energy_park/modules/home/presentation/screen/home_screen.dart';
import 'package:energy_park/modules/splash/presentation/bloc/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation animation;

  bool _visible = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(microseconds: 6000), vsync: this, value: 0.1);
    _controller.forward();
    setState(() {
      _visible = true;
    });
    animation = Tween(begin: 10.0, end: 20.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SplashBloc()..add(GetAppInitialData()),
        child: BlocListener<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state is NavigateToHome) {
              CustomProgressBar(context).hideLoadingIndicator();
              Navigator.push(context, CupertinoPageRoute(builder: (context) => const HomeScreen()));
            } else if (state is FailureState) {
              CustomProgressBar(context).hideLoadingIndicator();
              ScaffoldMessenger.of(context).showSnackBar(snackBarWidget(
                state.errorMessage,
                isError: true,
              ));
            } else if (state is SplashInitial) {
              CustomProgressBar(context).showLoadingIndicator();
            }
          },
          child: BlocBuilder<SplashBloc, SplashState>(
            builder: (context, state) {
              return showLogo();
            },
          ),
        ),
      ),
    );
  }

  Widget showLogo() {
    _controller.forward();
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0,
      duration: const Duration(seconds: 5),
      child: Center(
        child: Icon(
          Icons.library_books_sharp,
          color: AppColors.eventBackGroundColor,
          size: 150,
        ),
      ),
    );
  }
}
