import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:long_text_translator_gpt/bloc/startup/startup_cubit.dart';
import 'package:long_text_translator_gpt/bloc/main/main_cubit.dart';
import 'package:long_text_translator_gpt/repository/SettingsRepository.dart';
import 'package:long_text_translator_gpt/views/settings/SettingScreen.dart';

class StartupUI extends StatelessWidget {
  const StartupUI({super.key});

  void openSettings(BuildContext parentContext) {
    Navigator.of(parentContext).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: parentContext.read<MainCubit>(),
          child: RepositoryProvider.value(
            value: parentContext.read<SettingsRepository>(),
            child: const SettingScreen(),
          ),
        ),
      ),
    );
  }

  Widget buildInstantButton(BuildContext context) {
    return Container(
      width: 235,
      height: 161,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFE9E9E9),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            context.read<StartupCubit>().startInstantNote();
          },
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/instant.png", width: 20, height: 27),
                const SizedBox(height: 14),
                const Text(
                  "Instant Note",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "짧은 텍스트를 여러 번 번역할 때",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF676767),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.settings,
                  size: 18, color: Color(0xFF5D5D5D)),
              onPressed: () {
                openSettings(context);
              },
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "번역을 시작하세요",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 68),
              context.read<SettingsRepository>().settings.isOpenAIApiKeySet
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildInstantButton(context),
                      ],
                    )
                  : Center(
                      child: Column(
                        children: [
                          const Text(
                            "AI 번역을 사용하려면 설정에서 API 키를 입력하세요.",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF676767),
                            ),
                          ),
                          const SizedBox(height: 28),
                          ElevatedButton(
                            onPressed: () {
                              openSettings(context);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 36,
                                vertical: 22,
                              ),
                            ),
                            child: const Text("설정 바로가기"),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
