/*
class BottomSettings extends StatelessWidget {
  const BottomSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData myTheme = Theme.of(context);

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final SettingsCubit settingsCubit = getIt<SettingsCubit>();
        bool isEnglish = settingsCubit.languageCode == 'en';
        return Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(
            color: myTheme.colorScheme.primary,
            borderRadius: BorderRadius.only(
              topLeft: !isEnglish ? const Radius.circular(125) : Radius.zero,
              topRight: isEnglish ? const Radius.circular(125) : Radius.zero,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 20,
                  left: !isEnglish ? 90 : 0,
                  right: isEnglish ? 90 : 0,
                ),
                child: Text(
                  'app info',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20, color: myTheme.colorScheme.onPrimary),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'github link',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: myTheme.colorScheme.onPrimary,
                    decoration: TextDecoration.underline,
                    decorationColor: myTheme.colorScheme.onPrimary,
                  ),
                ),
              ),
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(children: [
                  TextSpan(
                    text: 'Havr problem',
                    style: TextStyle(
                      color: myTheme.colorScheme.onPrimary,
                    ),
                  ),
                  TextSpan(
                    text: 'Call us ',
                    style: TextStyle(
                      color: myTheme.colorScheme.primaryContainer,
                    ),
                  ),
                ]),
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
*/