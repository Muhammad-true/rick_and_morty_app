import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial(false)) {
    on<ToggleTheme>((event, emit) {
      emit(ThemeInitial(!state.isDark));
    });
  }
}
