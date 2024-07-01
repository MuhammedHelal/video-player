
/*
class DarkModeSwitch extends StatelessWidget {
  const DarkModeSwitch({
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
              'Dark modee',
            ),
            const SizedBox(
              width: 5,
            ),
            Switch(
              thumbColor: WidgetStateProperty.resolveWith((states) {
                // Change thumb color based on its state (active or inactive)
                if (states.contains(WidgetState.selected)) {
                  return Colors.deepPurple.shade100; // Active state color
                }
                return Colors.black12; // Inactive state color
              }),
              activeThumbImage: const AssetImage(Assets.assetsImagesDarkMode),
              inactiveThumbImage:
                  const AssetImage(Assets.assetsImagesLightMode),
              value: settingsCubit.darkMode,
              onChanged: !settingsCubit.autoTheme
                  ? (_) async {
                      await settingsCubit.toggleDarkTheme();
                    }
                  : null,
            ),
          ],
        );
      },
    );
  }
}
*/