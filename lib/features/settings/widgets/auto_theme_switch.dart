
/*
class AutoThemeSwitch extends StatelessWidget {
  const AutoThemeSwitch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final SettingsCubit settingsCubit = getIt<SettingsCubit>();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Auto',
            ),
            const SizedBox(
              width: 5,
            ),
            Switch(
              value: settingsCubit.autoTheme,
              onChanged: (_) async {
                await settingsCubit.autoThemeToggle();
              },
            ),
          ],
        );
      },
    );
  }
}
*/