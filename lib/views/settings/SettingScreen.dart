import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:long_text_translator_gpt/bloc/main/main_cubit.dart';
import 'package:long_text_translator_gpt/repository/SettingsRepository.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final TextEditingController _openApiKeyController = TextEditingController();

  bool saveEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "OpenAI API Key",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _openApiKeyController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter your OpenAI API Key",
              ),
              onChanged: (value) {
                setState(() {
                  saveEnabled = value.isNotEmpty;
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: saveEnabled
                  ? () async {
                      final settings = context.read<SettingsRepository>();
                      settings.saveSettings(settings.settings.copyWith(
                        openAIApiKey: _openApiKeyController.text,
                        isOpenAIApiKeySet: true,
                      ));

                      context.read<MainCubit>().reloadApp();
                    }
                  : null,
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
