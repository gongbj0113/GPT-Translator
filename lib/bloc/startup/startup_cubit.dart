import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:long_text_translator_gpt/model/translation_note/instant_note.dart';
import 'package:long_text_translator_gpt/repository/SettingsRepository.dart';

part 'startup_state.dart';

class StartupCubit extends Cubit<StartupState> {
  final SettingsRepository _settingsRepository;
  late Function(InstantNote instantNote) _onStartInstantNote;

  StartupCubit({required SettingsRepository settingsRepository})
      : _settingsRepository = settingsRepository,
        super(StartupState.initial()) {
    _onStartInstantNote = (_) {};
  }

  void init() {
    emit(StartupState.initial());
  }

  setOnStartInstantNote(Function(InstantNote instantNote) onStartInstantNote) {
    _onStartInstantNote = onStartInstantNote;
  }

  void startInstantNote() {
    _onStartInstantNote(
      InstantNote(
        title: '새로운 Instant Note',
        targetLanguage: _settingsRepository.settings.defaultTargetLanguage,
        records: [],
      ),
    );
  }
}
