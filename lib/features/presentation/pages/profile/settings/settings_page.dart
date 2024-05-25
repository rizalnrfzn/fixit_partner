import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';
import 'package:fixit_partner/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with MainBoxMixin {
  late final ActiveTheme _selectedTheme = sl<SettingsCubit>().getActiveTheme();

  late final List<DataHelper> _listLanguage = [
    DataHelper(title: Constants.get.english, type: "en"),
    DataHelper(title: Constants.get.bahasa, type: "id"),
  ];
  late DataHelper _selectedLanguage =
      (getData(MainBoxKeys.locale) ?? "id") == "id"
          ? _listLanguage[1]
          : _listLanguage[0];

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: MyAppBar(context, title: Strings.of(context)!.settings).call(),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Dimens.space24),
          child: Column(
            children: [
              DropDown<ActiveTheme>(
                key: const Key("dropdown_theme"),
                hint: Strings.of(context)!.chooseTheme,
                value: _selectedTheme,
                prefixIcon: const Icon(Icons.light),
                items: ActiveTheme.values
                    .map(
                      (data) => DropdownMenuItem(
                        value: data,
                        child: Text(
                          _getThemeName(data, context),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  /// Reload theme
                  context
                      .read<SettingsCubit>()
                      .updateTheme(value ?? ActiveTheme.system);
                },
              ),

              /// Language
              DropDown<DataHelper>(
                key: const Key("dropdown_language"),
                hint: Strings.of(context)!.chooseLanguage,
                value: _selectedLanguage,
                prefixIcon: const Icon(Icons.language_outlined),
                items: _listLanguage
                    .map(
                      (data) => DropdownMenuItem(
                        value: data,
                        child: Text(
                          data.title ?? "-",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (DataHelper? value) async {
                  _selectedLanguage = value ?? _listLanguage[1];

                  /// Reload theme
                  if (!mounted) return;
                  context
                      .read<SettingsCubit>()
                      .updateLanguage(value?.type ?? "id");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getThemeName(ActiveTheme activeTheme, BuildContext context) {
    if (activeTheme == ActiveTheme.system) {
      return Strings.of(context)!.themeSystem;
    } else if (activeTheme == ActiveTheme.dark) {
      return Strings.of(context)!.themeDark;
    } else {
      return Strings.of(context)!.themeLight;
    }
  }
}
