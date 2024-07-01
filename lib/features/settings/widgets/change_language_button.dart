/*
class ChangeLanguageButton extends StatelessWidget {
  const ChangeLanguageButton({
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
              'Change local',
            ),
            const SizedBox(
              width: 5,
            ),
            OutlinedButton(
              onPressed: () async {
                await settingsCubit.changeLocal();
              },
              child: Text(settingsCubit.getLocalCode()),
            ),
          ],
        );
      },
    );
  }
}
*/