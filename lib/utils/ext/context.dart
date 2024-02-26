import 'package:fixit_partner/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/core.dart';

extension ContextExtensions on BuildContext {
  bool isMobile() {
    final shortestSide = MediaQuery.of(this).size.shortestSide;

    return shortestSide < 600;
  }

  dynamic back([dynamic result]) => Navigator.pop(this, result);

  Future<dynamic> goTo(String routeName, {Object? args}) =>
      Navigator.pushNamed(this, routeName, arguments: args);

  Future<dynamic> goToReplace(String routeName, {Object? args}) =>
      Navigator.pushReplacementNamed(this, routeName, arguments: args);

  Future<dynamic> goToClearStack(String routeName, {Object? args}) =>
      Navigator.pushNamedAndRemoveUntil(
        this,
        routeName,
        (Route<dynamic> route) => false,
        arguments: args,
      );

  double widthInPercent(double percent) {
    final toDouble = percent / 100;

    return MediaQuery.of(this).size.width * toDouble;
  }

  double heightInPercent(double percent) {
    final toDouble = percent / 100;

    return MediaQuery.of(this).size.height * toDouble;
  }

  //Start Loading Dialog
  static late BuildContext ctx;

  Future<void> show() => showDialog(
        context: this,
        barrierDismissible: false,
        builder: (c) {
          ctx = c;

          return PopScope(
            canPop: false,
            child: Material(
              color: Colors.transparent,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(this).extension<MyAppColors>()!.background,
                    borderRadius: BorderRadius.circular(Dimens.cornerRadius),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: Dimens.space30),
                  padding: EdgeInsets.all(Dimens.space24),
                  child: const Loading(),
                ),
              ),
            ),
          );
        },
      );

  Future<void> showDialogSuccess(String message, String path) => showDialog(
        context: this,
        builder: (c) {
          ctx = c;

          return PopScope(
            child: Material(
              color: Colors.transparent,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(this).extension<MyAppColors>()!.background,
                    borderRadius: BorderRadius.circular(Dimens.cornerRadius),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: Dimens.space30),
                  padding: EdgeInsets.all(Dimens.space24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('berhasil'),
                      FilledButton(
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                          foregroundColor: Palette.background,
                          minimumSize: Size(150.w, 50.w),
                        ),
                        child: const Text('Simpan dan Daftar'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );

  void dismiss() {
    try {
      Navigator.pop(ctx);
    } catch (_) {}
  }
}
