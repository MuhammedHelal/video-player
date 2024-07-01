/* import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videoplayer/core/cubit/settings_cubit/settings_cubit.dart';
import 'package:videoplayer/core/cubit/settings_cubit/settings_state.dart';
import 'package:videoplayer/core/services/service_locator.dart';

class PipviewSwitch extends StatelessWidget {
  const PipviewSwitch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final SettingsCubit settingsCubit =
       getIt<SettingsCubit>();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'pip',
            ),
            const SizedBox(
              width: 5,
            ),
            Switch(
              value: settingsCubit.pipviewSwitch,
              onChanged: (_) async {
                await settingsCubit.pipviewToggle();
              },
            ),
          ],
        );
      },
    );
  }
}
*/