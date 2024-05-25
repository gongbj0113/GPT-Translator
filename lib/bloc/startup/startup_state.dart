part of 'startup_cubit.dart';

enum StartupMode {
  start,
  documentNoteConfigurations,
}

class StartupState extends Equatable {
  final StartupMode mode;

  const StartupState({
    this.mode = StartupMode.start,
  });

  factory StartupState.initial() {
    return const StartupState();
  }

  StartupState copyWith({
    StartupMode? mode,
    bool? isLoading,
  }) {
    return StartupState(
      mode: mode ?? this.mode,
    );
  }

  @override
  List<Object> get props => [mode];
}
