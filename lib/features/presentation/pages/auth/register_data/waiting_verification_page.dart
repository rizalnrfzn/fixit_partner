import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';
import 'package:fixit_partner/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          child: Center(
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return Text(
                    'Menunggu verifikasi ${context.read<AuthCubit>().authUser!.isVerified}');
              },
            ),
          ),
        ),
      ),
    );
  }
}
