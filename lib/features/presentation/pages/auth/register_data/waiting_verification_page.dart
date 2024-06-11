import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';
import 'package:fixit_partner/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class WaitingVerificationPage extends StatelessWidget {
  const WaitingVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Parent(
      appBar: MyAppBar(
        context,
        action: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text(
                  Strings.of(context)!.logout,
                  style: textTheme.bodyLarge,
                ),
                content: Text(
                  Strings.of(context)!.logoutDesc,
                  style: textTheme.bodyMedium,
                ),
                actions: [
                  TextButton(
                    onPressed: () => context.back(),
                    child: Text(
                      Strings.of(context)!.cancel,
                      style: textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context)
                            .extension<MyAppColors>()!
                            .subtitle,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<AuthCubit>().logout();
                    },
                    child: Text(
                      Strings.of(context)!.yes,
                      style: textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).extension<MyAppColors>()!.blue,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          icon: const Icon(Icons.logout),
        ),
      ).call(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            streamUser: (data) {
              if (data!.isVerified!) {
                context.go(Routes.root.path);
              }
            },
          );
        },
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(Images.icLogo,
                  width: 350.w,
                  color: Theme.of(context).extension<MyAppColors>()!.blue),
              Text(
                'Akun Anda sedang diverifikasi',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SpacerV(value: 20.w),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Silahkan tunggu 1x24 jam untuk verifikasi akun'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
