import 'dart:io';

import 'package:energy_park/config/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CustomProgressBar {
  final BuildContext context;

  CustomProgressBar(this.context);

  static bool progressbarStatus = false;

  void showLoadingIndicator() {
    if (ModalRoute.of(context)?.isCurrent ?? false) {
      showDialog(
        context: context,
        barrierDismissible: false,
        useSafeArea: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: const LoadingIndicator(),
          );
        },
      );
      progressbarStatus = true;
    }
  }

  void hideLoadingIndicator() {
    if (progressbarStatus == true) {
      Navigator.of(context).pop();
      progressbarStatus = false;
    }
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        // child: Gif(
        //   image: AssetImage("assets/gif/loading.gif"),
        //   // controller: _controller,
        //   // if duration and fps is null, original gif fps will be used.
        //   //fps: 30,
        //   //duration: const Duration(seconds: 3),
        //   autostart: Autostart.loop,
        //   placeholder: (context) => const Text('Loading...'),
        //   onFetchCompleted: () {
        //     // _controller.reset();
        //     // _controller.forward();
        //   },
        // ),
        child: Platform.isAndroid
            ? CircularProgressIndicator(
                color: AppColors.blueColor,
              )
            : CupertinoActivityIndicator(
                color: AppColors.blueColor,
                radius: 20,
                animating: true,
              ),
      ),
    );
  }
}
